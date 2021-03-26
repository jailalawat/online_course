# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  it 'has a valid factorybot' do
    expect(build(:organisation)).to be_valid
  end

  context '#validations' do
    it { should validate_presence_of(:name) }
  end
end
