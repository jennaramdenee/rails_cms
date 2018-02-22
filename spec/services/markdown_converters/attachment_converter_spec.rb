require_relative '../../rails_helper'

RSpec.describe MarkdownConverter::AttachmentConverter do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:original_article) { create(:original_article) }
  # let(:converted_article) { create(:converted_article) }

  context '#add_file_properties' do
    it 'can find images from a body of markdown' do
      expect(MarkdownConverter::AttachmentConverter.add_file_properties(original_article.body)).to include('(PDF, 243KB)')
    end
  end

  context '#extract_names_and_links' do
    context 'no names and links' do
      it 'can find images from a body of markdown' do
        expect(MarkdownConverter::AttachmentConverter.send(:extract_names_and_links, "Some Text")).to eq([])
      end
    end

    context 'with names and links' do
      it 'can find images from a body of markdown' do
        expect(MarkdownConverter::AttachmentConverter.send(:extract_names_and_links, original_article.body)).to eq([["Parliamentary Evolution", "https://www.parliament.uk/documents/parliamentary-archives/evolution.pdf"], ["Wikipedia", "https://en.wikipedia.org/wiki/Portable_Document_Format"]])
      end
    end
  end

  context '#valid_file_format' do
    context 'invalid file format' do
      it 'returns false' do
        expect(MarkdownConverter::AttachmentConverter.send(:valid_file_format?, '.html')).to eq false
      end
    end

    context 'valid file format' do
      it 'returns true' do
        expect(MarkdownConverter::AttachmentConverter.send(:valid_file_format?, '.pdf')).to eq true
      end
    end
  end


  let(:file_destination) { "#{Rails.root}/tmp/test_attachment" }
  let(:file) { "https://www.parliament.uk/documents/parliamentary-archives/evolution.pdf" }

  before do
    MarkdownConverter::AttachmentConverter.send(:open_and_save_file, file, file_destination)
  end

  # Only run the after block for specific specs
  after(:each, specific_specs: true) do
    File.delete(file_destination)
  end

  context '#open_and_save_file', specific_specs: true do
    it 'saves a file in a given destination' do
      expect(File).to exist(file_destination)
    end
  end

  context '#find_file_size', specific_specs: true do
    it 'returns file size in kilobytes' do
      expect(MarkdownConverter::AttachmentConverter.send(:find_file_size, file_destination)).to eq 243
    end
  end

  context '#find_file_type', specific_specs: true do
    it 'returns file type' do
      expect(MarkdownConverter::AttachmentConverter.send(:find_file_type, '.pdf')).to eq 'PDF'
    end
  end

  context '#delete_file' do
    it 'deletes a file from a given destination' do
      MarkdownConverter::AttachmentConverter.send(:delete_file, file_destination)
      expect(File).not_to exist(file_destination)
    end
  end

  context '#set_new_attachment_name' do
    it 'sets new attachment name, so that it includes file type and size' do
      expect(MarkdownConverter::AttachmentConverter.send(:set_new_attachment_name, original_article.body, 'Parliamentary Evolution', 'PDF', 243)).to include('[Parliamentary Evolution (PDF, 243KB)]')
    end
  end

end
