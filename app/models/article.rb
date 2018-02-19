require 'open-uri'

class Article < ApplicationRecord
  has_and_belongs_to_many :collections

  validates :title, presence: true

  def self.add_file_properties(body)
    extracted_names_and_links = body.scan(/\[([^\]]+)\]\((http[^)]+)\)/)

    # require 'irb'; binding.irb
    extracted_names_and_links.each_with_index do |extracted_name_and_link, index|
      if extracted_name_and_link[1].ends_with?('.doc') || extracted_name_and_link[1].ends_with?('.pdf')
        file_stream = open(extracted_name_and_link[1])
        IO.copy_stream(file_stream, "#{Rails.root}/tmp/#{index}")
        File.size(open("#{Rails.root}/tmp/#{index}"))
      end
    end
  end

  def self.create_params_hash(request_body)
    fields = request_body['fields']
    params_hash = {
      title: fields['title']['en-US'],
      summary: fields['summary']['en-US'],
      body: fields['body']['en-US']
    }
  end
end
