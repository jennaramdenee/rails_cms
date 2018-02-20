require_relative '../../rails_helper'

RSpec.describe MarkdownConverters::FootnoteConverter do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:original_article) { create(:original_article) }
  # let(:converted_article) { create(:converted_article) }

  context '#convert' do
    it 'correctly converts footnotes' do
      skip
    end
  end

  context '#extract_footnotes' do
    it 'can extract footnotes from markdown' do
      expect(MarkdownConverters::FootnoteConverter.send(:extract_footnotes, original_article.body).length).to eq 4
    end
  end


end
