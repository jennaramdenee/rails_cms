module MarkdownConverter
  class AttachmentConverter
    class << self

      ACCEPTED_FORMATS_HASH = {
        '.doc' => 'Word doc',
        '.pdf' => 'PDF'
      }

      def add_file_properties(markdown)
        extracted_names_and_links = extract_names_and_links(markdown)

        extracted_names_and_links.each_with_index do |extracted_name_and_link, index|
          file_extension            = File.extname(extracted_name_and_link[1])
          file_destination          = "#{Rails.root}/tmp/#{index}"

          return markdown unless valid_file_format?(file_extension)
          name = extracted_name_and_link[0]
          link = extracted_name_and_link[1]

          open_and_save_file(link, file_destination)

          file_size = find_file_size(file_destination)
          file_type = find_file_type(file_extension)

          delete_file(file_destination)

          set_new_attachment_name(markdown, name, file_type, file_size)
        end
        markdown
      end

      private

      def extract_names_and_links(markdown)
        markdown.scan(/\[([^\]]+)\]\((https[^)]+)\)/)
      end

      def valid_file_format?(file_extension)
        ACCEPTED_FORMATS_HASH.keys.include?(file_extension)
      end

      def open_and_save_file(file, file_destination)
        IO.copy_stream(open(file), file_destination)
      end

      def find_file_size(file_destination)
        File.size(open(file_destination)) / 1000
      end

      def find_file_type(file_extension)
        ACCEPTED_FORMATS_HASH[file_extension]
      end

      def delete_file(file_destination)
        File.delete(file_destination)
      end

      def set_new_attachment_name(markdown, old_name, file_type, file_size)
        # TODO: Consider MB, GB conversion
        new_name = "#{old_name} (#{file_type}, #{file_size}KB)"
        markdown.gsub!(old_name, new_name)
      end
    end
  end
end
