# frozen_string_literal: true

FactoryBot.define do
  factory :course, class: Course do
    title { faker_generate_name }
    description { faker_generate_paragraph }
    source_id { unique_number }
    price { Faker::Commerce.price }
    association :organisation, factory: :organisation
  end
end
