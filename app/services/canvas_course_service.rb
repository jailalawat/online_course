# frozen_string_literal: true

require 'open-uri'

class CanvasCourseService < BaseCourseService
  def initialize(url)
    api_url = url
    @response_json_datas = JSON.load(URI.open(api_url))['products']
  end

  private

  def create_course(json_data)
    Course.find_or_create_by!(title: json_data['title']) do |ce|
      ce.source_id = json_data['id'],
                     ce.description = json_data['teaser'],
                     ce.price = json_data['priceWithCurrency']&.gsub!(/[^0-9A-Za-z]/, '')
      ce.organisation_id = create_organisation(json_data).id
    end
  end

  def create_organisation(json_data)
    name = json_data['logo']['label']
    Organisation.find_or_create_by(name: name)
  end

  def attach_images(json_data, course)
    _url = URI.open(json_data['image'])
    primary_image = course.images.build(primary: true)
    primary_image.image.attach(io: _url, filename: 'primary_image.jpg')
    primary_image.save
  end

  def create_categories(json_data, course)
    course.category_ids = Category.find_or_create_by(name: json_data['type'])&.id
  end
end
