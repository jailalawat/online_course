# frozen_string_literal: true

class Organisation < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :slug, presence: true
end
