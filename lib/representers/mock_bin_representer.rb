class MockBinRepresenter < Representable::Decorator

  include Representable::JSON

  STATUS_DICTIONARY = {
    enabled: 'active',
    halt: 'paused',
    disabled: 'deleted'
  }.with_indifferent_access

  property :status,
           setter: ->(fragment:, represented:, **) { represented.status = STATUS_DICTIONARY[fragment] },
           skip_parse: ->(fragment:, **) { fragment.empty? }
  property :external_reference, as: :reference
  property :ad_description, as: :description

end
