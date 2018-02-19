require_relative '../rails_helper'

RSpec.describe Article do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:article) { create(:article) }
  let(:request_body) { JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/post_request_body")) }

  context '#add_file_properties' do
    xit 'can find images from a body of markdown' do
      expect(Article.add_file_properties(article.body)).to eq(File.read("#{Rails.root}/spec/fixtures/correct_markdown_body.txt"))
    end
  end

  context '#create_params_hash' do
    it 'creates a hash containing title, summary and body of a request' do
      expect(Article.create_params_hash(request_body)[:title]).to include("How to submit an oral question online")
      expect(Article.create_params_hash(request_body)[:summary]).to include("These steps are for submitting an oral question online")
      expect(Article.create_params_hash(request_body)[:body]).to include("The Table Office will check your question")
    end
  end


end
