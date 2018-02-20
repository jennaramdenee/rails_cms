module MarkdownConverters
  class FootnoteConverter
    class << self
      def convert(markdown)
        extract_footnotes(markdown).each do |footnotes|
          full_footnote      = footnotes[0]
          footnote_marker    = footnotes[1]
          footnote_character = footnotes[2]
          footnote_text      = footnotes[3]

          markdown.gsub!(full_footnote, footer_html(footnote_character, footnote_text))
          markdown.gsub!(footnote_marker, marker_html(footnote_character))
        end

        markdown
      end

      private

      def extract_footnotes(markdown)
        markdown.scan(/((\[\^(.+)?\])[:]\s(.+))/)
      end

      def marker_html(footnote_character)
        "<a href='##{footnote_character}'>#{footnote_character}</a>"
      end

      def footer_html(footnote_character, footnote_text)
        "<a name='##{footnote_character}'>#{footnote_text}</a>"
      end
    end
  end
end
