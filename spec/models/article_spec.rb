require_relative '../rails_helper'

RSpec.describe Article do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:article) { create(:article) }
  let(:transformed_article) { create(:transformed_article) }
  let(:request_body) { JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/successful_request_body")) }

  context '#add_file_properties' do
    it 'can find images from a body of markdown' do
      expect(Article.add_file_properties(article.body)).to include('(PDF, 45KB)')
    end
  end

  context '#extract_params' do
    it 'creates a hash containing title, summary and body of a request' do
      expect(Article.extract_params(request_body)[:title]).to include("How to submit an oral question online")
      expect(Article.extract_params(request_body)[:summary]).to include("These steps are for submitting an oral question online")
      expect(Article.extract_params(request_body)[:body]).to include("The Table Office will check your question")
    end
  end


end
