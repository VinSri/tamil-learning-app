require 'net/http'

class AudioController < ApplicationController
  skip_before_action :authenticate_user!

  def tts
    raw = params[:text].to_s.strip
    return head :bad_request if raw.blank?

    text = clean_tamil(raw)
    return head :bad_request if text.blank?

    uri = URI("https://translate.google.com/translate_tts")
    uri.query = URI.encode_www_form(ie: 'UTF-8', client: 'tw-ob', tl: 'ta', q: text)

    http          = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl  = true
    http.open_timeout = 5
    http.read_timeout = 10

    request = Net::HTTP::Get.new(uri)
    request['User-Agent'] = 'Mozilla/5.0 (X11; Linux x86_64)'
    request['Referer']    = 'https://translate.google.com/'

    response = http.request(request)
    send_data response.body, type: 'audio/mpeg', disposition: 'inline'
  rescue => e
    Rails.logger.warn "TTS error: #{e.message}"
    head :service_unavailable
  end

  private

  def clean_tamil(text)
    text
      .split('|').first                        # first example only
      .gsub(/\(.*?\)/, '')                     # remove (English notes)
      .gsub(/[a-zA-Z0-9.,!?:;\/\-–—]/, '')    # remove Latin characters
      .gsub(/\u0BCD/, '')                      # strip pulli from consonants
      .gsub(/\s+/, ' ')
      .strip
  end
end
