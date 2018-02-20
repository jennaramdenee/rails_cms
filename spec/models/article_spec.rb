require_relative '../rails_helper'

RSpec.describe Article do
  let(:request_body) { JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/successful_request_body")) }

  context '#format_newlines' do
    it 'formats new lines correctly' do
      expect(Article.format_newlines("Some text. \\n Testing.")).to eq("Some text. \n Testing.")
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
