require_relative './markdown_converters/attachment_converter'
require_relative './markdown_converters/footnote_converter'

module MarkdownConverter
  def self.convert(markdown)
    MarkdownConverter::FootnoteConverter.convert(markdown)
    MarkdownConverter::AttachmentConverter.add_file_properties(markdown)
  end
end
