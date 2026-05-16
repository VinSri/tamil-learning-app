namespace :nigandu do
  desc "Translate Nigandu headwords to English using Claude API (skips already translated)"
  task translate: :environment do
    require 'anthropic'

    client = Anthropic::Client.new(api_key: ENV.fetch('ANTHROPIC_API_KEY'))

    entries = NiganduEntry.where(english: nil).ordered
    total   = entries.count
    puts "#{total} entries to translate..."

    entries.each_slice(50).with_index do |batch, i|
      pairs = batch.map { |e| "#{e.id}|#{e.headword}" }.join("\n")

      response = client.messages(
        model:      'claude-haiku-4-5-20251001',
        max_tokens: 1024,
        messages:   [{
          role:    'user',
          content: <<~PROMPT
            These are headwords from the Pingala Nigandu, a classical Tamil thesaurus.
            Each headword names a concept whose Tamil synonyms are grouped under it.
            Translate each headword to a concise English phrase (2–5 words max).

            Format: id|english_translation — one per line, nothing else.

            #{pairs}
          PROMPT
        }]
      )

      response.content.first[:text].strip.each_line do |line|
        id, english = line.strip.split('|', 2)
        next unless id&.match?(/\A\d+\z/) && english.present?
        NiganduEntry.where(id: id.to_i).update_all(english: english.strip)
      end

      done = (i + 1) * 50
      puts "  #{[done, total].min}/#{total} translated"
      sleep 0.3
    end

    puts "Done. #{NiganduEntry.where.not(english: nil).count} entries now have English."
  end
end
