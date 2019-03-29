class CampaignDiffService

  class << self
    DIFF_ATTRIBUTES = %i[status ad_description].freeze

    delegate :external_reference, to: :@local

    def call(local:, remote:, diff_attributes: DIFF_ATTRIBUTES)
      @local = local
      @remote = remote
      @diff_attributes = diff_attributes

      result
    end

    private

    def result
      @discrepancies = discrepancies

      return nil if discrepancies.empty?

      {
        remote_reference: external_reference,
        discrepancies: discrepancies
      }
    end

    def discrepancies
      @diff_attributes.map do |attribute|
        local_value = @local[attribute]
        remote_value = @remote[attribute]

        next if local_value == remote_value

        discrepancy_for(attribute, local_value, remote_value)
      end.compact
    end

    def discrepancy_for(attribute, local_value, remote_value)
      {
        attribute => {
          remote: remote_value,
          local: local_value
        }
      }
    end

  end

end
