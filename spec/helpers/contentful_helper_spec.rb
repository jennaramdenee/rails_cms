require_relative '../rails_helper'

RSpec.describe ContentfulHelper do
  let(:request_body) { JSON.parse(eval File.read("#{Rails.root}/spec/fixtures/successful_request_body")) }

  context '#set_up' do
    before do
      ContentfulHelper.send(:set_up, request_body)
    end
    it 'creates a Contentful client' do
      expect(ContentfulHelper.instance_variable_get('@client').class).to eq(Contentful::Management::Client)
    end

    it 'retrieves space id' do
      expect(ContentfulHelper.instance_variable_get('@space_id')).not_to be nil
    end

    it 'retrieves entry id' do
      expect(ContentfulHelper.instance_variable_get('@entry_id')).not_to be nil
    end
  end

  context 'if it does not exist' do
    it 'returns nil' do
      expect(ContentfulHelper.send(:space_id, {})).to eq(nil)
    end
  end
  
  context '#entry_id' do
    context 'if it exists' do
      it 'returns entry ID' do
        expect(ContentfulHelper.send(:entry_id, request_body)).to eq('4n39BiAiKQWicQSIsC0kEK')
      end
    end

    context 'if it does not exist' do
      it 'returns nil' do
        expect(ContentfulHelper.send(:entry_id, {})).to eq(nil)
      end
    end
  end

  context '#space_id' do
    context 'if it exists' do
      it 'returns space ID' do
        expect(ContentfulHelper.send(:space_id, request_body)).to eq('3t6txrpcx29n')
      end
    end

    context 'if it does not exist' do
      it 'returns nil' do
        expect(ContentfulHelper.send(:space_id, {})).to eq(nil)
      end
    end
  end
end
