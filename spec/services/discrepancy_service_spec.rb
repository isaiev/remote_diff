require 'spec_helper'

describe DiscrepancyService do
  let(:service) { DiscrepancyService }
  let(:external_resource) { ExternalResources::MockBin }

  let!(:active_campaign_1) { create(:campaign, :active, external_reference: 1, ad_description: 'Hello') }
  let!(:active_campaign_2) { create(:campaign, :active, external_reference: 2, ad_description: 'Description for campaign 12') }
  let!(:paused_campaign_1) { create(:campaign, :paused, external_reference: 3, ad_description: 'Help') }
  let!(:paused_campaign_2) { create(:campaign, :paused, external_reference: 4, ad_description: 'Description for campaign 14') }
  let!(:deleted_campaign_1) { create(:campaign, :deleted, external_reference: 5, ad_description: 'Desc 15') }
  let!(:deleted_campaign_2) { create(:campaign, :deleted, external_reference: 6, ad_description: 'Description for campaign 16') }

  describe '.call' do

    it 'has method call accepting model and external_resource' do
      expect(service).to respond_to(:call).with_keywords(:external_resource)
    end

    context 'with success response' do
      let(:stubbed_response) do
        { 'ads' => [
          { 'reference' => '1', 'status' => 'enabled', 'description' => 'Description for campaign 11' },
          { 'reference' => '2', 'status' => 'disabled', 'description' => 'Description for campaign 12' },
          { 'reference' => '3', 'status' => 'halt', 'description' => 'Description for campaign 13' },
          { 'reference' => '4', 'status' => 'enabled', 'description' => 'Description for campaign 14' },
          { 'reference' => '5', 'status' => 'disabled', 'description' => 'Description for campaign 15' },
          { 'reference' => '6', 'status' => 'halt', 'description' => 'Description for campaign 16' }
        ] }
      end
      before(:each) do
        stub_request(:get, external_resource.url)
          .to_return(
            body: stubbed_response.to_json,
            status: 200
          )
      end

      it 'returns correct discrepancy' do
        discrepancy = service.call(external_resource: external_resource)
        expected = [
          {
            remote_reference: 1,
            discrepancies: [
              ad_description: {
                remote: 'Description for campaign 11',
                local: 'Hello'
              }
            ]
          },
          {
            remote_reference: 2,
            discrepancies: [
              status: {
                remote: 'deleted',
                local: 'active'
              }
            ]
          },
          {
            remote_reference: 3,
            discrepancies: [
              ad_description: {
                remote: 'Description for campaign 13',
                local: 'Help'
              }
            ]
          },
          {
            remote_reference: 4,
            discrepancies: [
              status: {
                remote: 'active',
                local: 'paused'
              }
            ]
          },
          {
            remote_reference: 5,
            discrepancies: [
              ad_description: {
                remote: 'Description for campaign 15',
                local: 'Desc 15'
              }
            ]
          },
          {
            remote_reference: 6,
            discrepancies: [
              status: {
                remote: 'paused',
                local: 'deleted'
              }
            ]
          }
        ]

        expect(discrepancy).to eq(expected)
      end
    end

  end

end
