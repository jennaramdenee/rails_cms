require_relative '../rails_helper'

RSpec.describe MarkdownConverters::AttachmentConverter do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:original_article) { create(:original_article) }
  let(:converted_article) { create(:converted_article) }

  context '#add_file_properties' do
    it 'can find images from a body of markdown' do
      expect(article.add_file_properties(article.body)).to include('(PDF, 243KB)')
    end
  end

end
