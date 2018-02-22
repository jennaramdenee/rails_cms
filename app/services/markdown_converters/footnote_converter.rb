module MarkdownConverter
  class FootnoteConverter
    class << self
      def convert(markdown)
        extract_footnotes(markdown).each do |footnotes|
          footnote = Footnote.new(footnotes[0], footnotes[1], footnotes[2], footnotes[3])
          next unless footnote.valid?

          markdown.gsub!(footnote.full, footer_html(footnote.character, footnote.text))
          markdown.gsub!(footnote.marker, marker_html(footnote.character))
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

      Footnote = Struct.new(:full, :marker, :character, :text) do
        def valid?
          [full, marker, character, text].none?(&:empty?)
        end
      end
    end
  end
end
