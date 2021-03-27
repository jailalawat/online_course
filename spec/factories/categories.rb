# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: Category do
    name { faker_generate_name }
  end
end
