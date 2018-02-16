require_relative '../rails_helper'

RSpec.describe Article do
  # Make factory, and inside of the body load a fixture file with markdown

  let(:article) { create(:article) }

  context '#add_file_properties' do
    it 'can find images from a body of markdown' do
      expect(Article.add_file_properties(article.body)).to eq(File.read("#{Rails.root}/spec/fixtures/correct_markdown_body.txt"))
    end
  end

end
