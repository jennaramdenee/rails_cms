require_relative '../rails_helper'

RSpec.describe ArticlesController do
  context '#create' do
    let(:successful_request) { post :create, body: JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/successful_request_body")).to_json }
    let(:bad_request) { post :create, body: JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/bad_request_body")).to_json }

    context 'when successful' do
      it 'redirects to article page ' do
        successful_request
        expect(response).to redirect_to '/articles/1'
      end
    end

    context 'when unsuccessful' do
      it 'raises an error' do
        expect { bad_request }.to raise_error(StandardError, 'Failed to create article')
      end
    end
  end

end
