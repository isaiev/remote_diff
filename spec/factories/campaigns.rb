FactoryBot.define do
  factory :campaign do

    sequence(:job_id) { |n| n }
    sequence(:external_reference) { |n| n }
    sequence(:ad_description) { |n| "Description for #{n}" }

    trait :active do
      status { 'active' }
    end

    trait :paused do
      status { 'paused' }
    end

    trait :deleted do
      status { 'deleted' }
    end

  end
end
