module ApplicationHelper
  # Splits Tamil text into tokens and wraps annotated words in clickable spans.
  def annotated_passage(text, annotations)
    return h(text) if annotations.blank?

    lines = text.split("\n")
    safe_lines = lines.map do |line|
      tokens = line.split(/(\s+)/)
      safe_tokens = tokens.map do |token|
        next h(token) if token.match?(/\A\s+\z/)

        # Strip trailing punctuation for lookup but preserve it for display
        bare = token.gsub(/[।\.,:;!?\-–""''()\[\]]+\z/, "")
        punct = token[bare.length..]

        ann = annotations[bare]
        if ann
          meaning = h(ann["meaning"] || ann[:meaning])
          role    = h(ann["role"]    || ann[:role])
          content_tag(:span,
            (h(bare) + h(punct)).html_safe,
            class: "annotated-word",
            data:  { meaning: meaning, role: role }
          )
        else
          h(token)
        end
      end
      safe_join(safe_tokens)
    end

    safe_join(safe_lines, tag(:br))
  end
end
