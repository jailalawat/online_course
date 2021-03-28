# frozen_string_literal: true

class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :slug, :source_id, :price, :description, :provider, presence: true
  validates :price, numericality: { only_float: true }
  validates :title, presence: true, uniqueness: true

  belongs_to :organisation
  has_many :course_categories, dependent: :destroy
  has_many :categories, through: :course_categories
  has_many :images, as: :resource

  def primary_image
    images.find_by(primary: true)
  end
end
