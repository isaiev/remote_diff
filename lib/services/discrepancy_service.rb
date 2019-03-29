class DiscrepancyService

  class << self

    delegate :representer, :url, :parse_response, to: :@external_resource

    def call(external_resource:)
      @external_resource = external_resource

      discrepancies
    end

    private

    def discrepancies
      parsed_response.map do |remote_hash|
        remote_campaign = representer.new(Campaign.new).from_hash(remote_hash)
        local_campaign = Campaign.find_by(external_reference: remote_campaign[:external_reference])

        next unless local_campaign

        CampaignDiffService.call(local: local_campaign, remote: remote_campaign)
      end.compact
    end

    def parsed_response
      @parsed_response ||= parse_response(response.body)
    end

    def response
      HTTParty.get(url)
    end
  end

end
