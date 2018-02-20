require_relative './markdown_converters/attachment_converter'
require_relative './markdown_converters/footnote_converter'

module MarkdownConverters

  def self.convert(markdown)
    converted_markdown = MarkdownConverters::FootnoteConverter.convert(markdown)
    MarkdownConverters::AttachmentConverter.add_file_properties(converted_markdown)
  end

end
