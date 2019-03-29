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

  describe '.top_level_key' do
    it 'has method top_key' do
      expect(external_resource).to respond_to(:top_level_key)
    end

    it 'is a string' do
      expect(external_resource.url).to be_a(String)
    end
  end

end
