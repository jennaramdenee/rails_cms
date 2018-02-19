require 'open-uri'

class Article < ApplicationRecord
  has_and_belongs_to_many :collections
  validates :title, presence: true

  def self.add_file_properties(body)
    extracted_names_and_links = body.scan(/\[([^\]]+)\]\((https[^)]+)\)/)

    # Find out the size and type of the attachment
    extracted_names_and_links.each_with_index do |extracted_name_and_link, index|
      # extracted_name_and_link[1].ends_with?('.doc')
      if extracted_name_and_link[1].ends_with?('.pdf')
        file_stream = open(extracted_name_and_link[1])
        IO.copy_stream(file_stream, "#{Rails.root}/tmp/#{index}")
        file_size = File.size(open("#{Rails.root}/tmp/#{index}"))
        file_type = 'PDF'

        p extracted_name_and_link
      end

      # TODO: Amend name and link to include additional info
    end
  end

  def self.replace_images(body)
    # extracted_image_links =
  end

  def self.generate_pdf(body)
  end

  def self.extract_params(request_body)
    fields = request_body['fields']
    params_hash = {
      title: fields['title']['en-US'],
      summary: fields['summary']['en-US'],
      # Body will probably be replaced once add_file_properties and replace_images have been run
      body: fields['body']['en-US']
    }
  end

  # Final output
  def self.create_params_hash(request_body)
    params_hash = extract_params(request_body)
    params_hash[:body] = add_file_properties(params_hash[:body])
    params_hash
  end

end
