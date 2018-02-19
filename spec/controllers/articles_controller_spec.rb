require_relative '../rails_helper'

RSpec.describe ArticlesController do
  context '#create' do
    before do
      post :create, body: JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/post_request_body")).to_json
    end

    context 'when successful' do
      it 'redirects to article page ' do
        expect(response).to redirect_to '/articles/1'
      end
    end
  end

end
