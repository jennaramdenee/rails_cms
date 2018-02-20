require 'open-uri'

class Article < ApplicationRecord
  has_and_belongs_to_many :collections
  validates :title, presence: true

  ACCEPTED_FORMATS_HASH = {
    '.doc' => 'Word doc',
    '.pdf' => 'PDF'
  }

  def self.format_newlines(body)
    body.gsub!(/\\n|\\n\\n/, "\n")
  end

  def self.extract_params(request_body)
    fields = request_body['fields']
    params_hash = {
      title: fields.dig('title', 'en-US'),
      summary: fields.dig('summary', 'en-US'),
      body: fields.dig('body', 'en-US')
    }
  end

  # Final output
  def self.create_params_hash(request_body)
    params_hash = Article.extract_params(request_body)

    params_hash[:body] = Article.format_newlines(params_hash[:body])
    params_hash[:body] = MarkdownConverters.convert(params_hash[:body])

    params_hash
  end

end
