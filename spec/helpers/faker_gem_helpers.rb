# frozen_string_literal: true

module FakerGemHelpers
  def faker_generate_name
    Faker::Commerce.product_name + unique_number
  end

  def faker_generate_paragraph
    Faker::Lorem.paragraph(sentence_count: 50)
  end

  def integer_number(_digits = 2)
    Faker::Number.number(digits: 2)
  end

  def unique_number
    integer_number(10).to_s
  end
end

RSpec.configure do |config|
  config.include FakerGemHelpers
end
