require 'open-uri'

class Article < ApplicationRecord
  attr_accessor :title, :summary, :body

  def self.add_file_properties(body)
    # links = body.split(" ").map do |word|
    #   require 'irb'; binding.irb
    #   word.scan(/\[.+\]\((http.+.pdf|\.doc)\)/)
    # end

    extracted_names_and_links = body.scan(/\[([^\]]+)\]\((http[^)]+)\)/)

    require 'irb'; binding.irb
    extracted_names_and_links.each_with_index do |extracted_name_and_link, index|
      if extracted_name_and_link[1].ends_with?('.doc') || extracted_name_and_link[1].ends_with?('.pdf')
        file_stream = open(extracted_name_and_link[1])
        IO.copy_stream(file_stream, "#{Rails.root}/tmp/#{index}")
        File.size(open("#{Rails.root}/tmp/#{index}"))
      end
    end

  end
end
