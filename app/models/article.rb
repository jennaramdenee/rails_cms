require 'open-uri'

class Article < ApplicationRecord
  has_and_belongs_to_many :collections
  validates :title, presence: true

  ACCEPTED_FORMATS_HASH = {
    '.doc' => 'Word doc',
    '.pdf' => 'PDF'
  }

  def self.add_file_properties(body)
    extracted_names_and_links = body.scan(/\[([^\]]+)\]\((https[^)]+)\)/)

    extracted_names_and_links.each_with_index do |extracted_name_and_link, index|
      if ACCEPTED_FORMATS_HASH.keys.include?(File.extname(extracted_name_and_link[1]))
        file_stream = open(extracted_name_and_link[1])
        IO.copy_stream(file_stream, "#{Rails.root}/tmp/#{index}")

        file_size = File.size(open("#{Rails.root}/tmp/#{index}")) / 1000
        file_type = ACCEPTED_FORMATS_HASH[(File.extname(extracted_name_and_link[1]))]

        File.delete("#{Rails.root}/tmp/#{index}")

        new_name = "#{extracted_name_and_link[0]} (#{file_type}, #{file_size}KB)"
        body.gsub!(extracted_name_and_link[0], new_name)
      end
    end

    body
  end

  def self.replace_images(body)
    # extracted_image_links =
  end

  def self.generate_pdf(body)
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
    params_hash = extract_params(request_body)
    params_hash[:body] = add_file_properties(params_hash[:body])
    params_hash
  end

end
