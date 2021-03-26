# frozen_string_literal: true

FactoryBot.define do
  factory :organisation, class: Organisation do
    name { faker_generate_name }
  end
end
