require 'spec_helper'

describe ExternalResources::MockBin do

  let(:external_resource) { ExternalResources::MockBin }

  describe '.url' do
    it 'has method url' do
      expect(external_resource).to respond_to(:url)
    end

    it 'is a string' do
      expect(external_resource.url).to be_a(String)
    end
  end

  describe '.representer' do
    it 'has method top_key' do
      expect(external_resource).to respond_to(:representer)
    end

    it 'is has method #from_hash' do
      expect(external_resource.representer.method_defined?(:from_hash)).to eq(true)
    end
  end

  describe '.parse_response' do
    it 'correctly parses response' do
      response_body = { ads: [{ a: 1 }] }

      expect(external_resource.parse_response(response_body.to_json)).to eq([{ 'a' => 1 }])
    end

  end

end
