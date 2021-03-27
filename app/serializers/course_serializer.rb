class CourseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  attributes :title, :slug, :price, :description, :short_description, :free, :primary_image_url, :images
  belongs_to :organisation, serializer: OrganisationSerializer
  has_many :categories, serializer: CategorySerializer

  def primary_image_url
    primary_image = object.primary_image
    if primary_image
      rails_blob_url(object.primary_image.image)
    else
      'http://content.codecademy.com/PRO/skill-paths/banner-images/visualize_data_python_header.png'
    end
  end

  def free
    object.price.to_f > 0 ? false : true
  end

  def description
    truncate(strip_tags(object.description), length: 200)
  end
end
