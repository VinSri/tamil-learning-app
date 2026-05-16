require "nokogiri"

namespace :nigandu do
  desc "Import Pingala Nigandu entries from HTML source files"
  task import: :environment do
    files = [
      { path: "docs/nigandu/pingala_nigandu_01.html", part: 1 },
      { path: "docs/nigandu/pingala_nigandu_03.html", part: 3 },
      { path: "docs/nigandu/pingala_nigandu_04.html", part: 4 }
    ]

    CATEGORY_MAP = {
      "வான்வகை"                      => "celestial",
      "வானவர் வகை"                   => "deities",
      "வானவர்வகை"                    => "deities",
      "ஐயர்வகை"                      => "ascetics",
      "அவனிவகை"                      => "geography",
      "ஆடவர்வகை"                     => "men",
      "அநுபோகவகை"                    => "objects",
      "பண்பிற்செயலிற்பகுதிவகை"      => "qualities",
      "மாப்பெயர்வகை"                 => "animals",
      "மரப்பெயர்வகை"                 => "plants",
      "ஒருசொற்பல்பொருள்வகை"         => "polysemy"
    }

    total = 0

    files.each do |file_info|
      path = Rails.root.join(file_info[:path])
      unless File.exist?(path)
        puts "SKIP: #{path} not found"
        next
      end

      puts "Parsing #{file_info[:path]} (part #{file_info[:part]})..."
      html = File.read(path, encoding: "UTF-8")
      doc  = Nokogiri::HTML(html)

      current_category = nil
      entries = []

      doc.css("body").children.each do |node|
        text = node.text.strip
        next if text.empty?

        # Detect section header lines
        if node.name =~ /^h[2-4]$/i || (node["class"].to_s =~ /section|header/)
          CATEGORY_MAP.each do |tamil, english|
            if text.include?(tamil)
              current_category = english
              break
            end
          end
          next
        end

        # Also check plain text nodes and <br>-terminated lines
        text.each_line do |line|
          line = line.strip
          next if line.empty?

          # Detect category from inline text (e.g. table of contents or section headings)
          CATEGORY_MAP.each do |tamil, english|
            if line.include?(tamil)
              current_category = english
            end
          end

          # Match entry: starts with a number followed by . or space
          # e.g. "1. சொல் பெயர் - synonyms"  or  "3031 சொல் - synonyms  (1)"
          next unless line =~ /\A(\d+)[.\s]+(.+)/

          sutra_number = $1.to_i
          rest         = $2.strip

          # Split on first " - " or "-" to get headword vs synonyms
          if rest =~ /\A(.+?)\s+-\s+(.+)/
            raw_head  = $1.strip
            syns_text = $2.strip
          elsif rest =~ /\A(.+?)-(.+)/
            raw_head  = $1.strip
            syns_text = $2.strip
          else
            next
          end

          # Clean headword: strip "பெயர்" suffix and trailing punctuation
          headword = raw_head.sub(/\s*பெயர்\s*\z/, "").gsub(/[.\s]+\z/, "").strip

          # Clean synonyms: remove trailing count like "(1)", strip punctuation
          syns_text = syns_text.gsub(/\(\d+\)\s*\z/, "").gsub(/[.\;]+\z/, "").strip

          # Split synonyms on common Tamil conjuncts and spaces
          synonyms = syns_text
            .gsub(/\s+-\s+/, " ")   # inline dashes used as line breaks in long entries
            .split(/\s+(?=[^\s]{2,})/)  # split on whitespace between multi-char words
            .map(&:strip)
            .reject(&:empty?)

          next if headword.empty? || synonyms.empty?

          entries << {
            sutra_number: sutra_number,
            headword:     headword,
            synonyms:     synonyms,
            category:     current_category,
            part:         file_info[:part],
            created_at:   Time.current,
            updated_at:   Time.current
          }
        end
      end

      # Bulk insert, skip duplicates
      inserted = NiganduEntry.insert_all(entries, unique_by: :sutra_number)
      count = inserted.length
      puts "  Inserted #{count} entries"
      total += count
    end

    puts "\nDone. Total entries imported: #{total}"
  end

  desc "Clear all Nigandu entries"
  task clear: :environment do
    count = NiganduEntry.delete_all
    puts "Deleted #{count} nigandu entries"
  end
end
