require_relative '../rails_helper'

RSpec.describe MarkdownConverter do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:original_article) { create(:original_article) }
  let(:converted_article) { create(:converted_article) }

  context '#convert' do
    before do
      @body = Article.format_newlines(original_article.body)
    end

    it 'converts markdown' do
      expect(MarkdownConverter.convert(@body)).to eq(converted_article.body)
    end
  end
end
