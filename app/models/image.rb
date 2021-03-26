# frozen_string_literal: true

class Image < ApplicationRecord
  CONTENT_TYPE = %w[image/png
                    image/jpeg
                    image/gif
                    image/jpg
                    image/bmp
                    image/tiff
                    image/webp
                    image/svg+xml].freeze
  IMG_MAX_SIZE = 25.megabytes
  VALID_ATTACHABLES = %w[Course Review].freeze

  validates :image,
            attached: true,
            content_type: CONTENT_TYPE,
            size: { less_than: IMG_MAX_SIZE }
  validates :resource_type, :resource_id, presence: true
  validates :resource_type, inclusion: { in: VALID_ATTACHABLES }

  belongs_to :resource, polymorphic: true
  has_one_attached :image
end
