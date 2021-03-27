# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'has a valid factorybot' do
    expect(build(:course)).to be_valid
  end

  context '#associations' do
    it { should belong_to(:organisation) }
    it { should have_many(:images) }
    it { should have_many(:course_categories) }
    it { should have_many(:categories).through(:course_categories) }
  end

  context '#validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:source_id) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }

    subject { create(:course) }
    it {
      should validate_uniqueness_of(:title)
    }
  end
end
