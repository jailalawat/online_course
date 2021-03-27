# frozen_string_literal: true

require 'open-uri'

class FutureLearnCourseService < BaseCourseService
  private

  def create_course(json_data)
    Course.find_or_create_by!(title: json_data['name']) do |ce|
      ce.source_id = json_data['uuid'],
                     ce.description = json_data['description'],
                     ce.short_description = json_data['introduction'],
                     ce.organisation_id = create_organisation(json_data).id
    end
  end

  def create_organisation(json_data)
    name = json_data['organisation']['name']
    Organisation.find_or_create_by(name: name)
  end

  def attach_images(json_data, course)
    img_url = json_data['header_image_url']
    if img_url =~ URI::DEFAULT_PARSER.make_regexp
      _url = URI.open(img_url)
      primary_image = course.images.build(primary: true)
      primary_image.image.attach(io: _url, filename: 'primary_image.jpg')
      primary_image.save
    end

    img_url = json_data['image_url']
    if img_url =~ URI::DEFAULT_PARSER.make_regexp
      _url = URI.open(img_url)
      image = course.images.build
      image.image.attach(io: _url, filename: 'image.jpg')
      image.save
    end
  end

  def create_categories(json_data, course)
    category_ids = []
    json_data['categories'].each do |name|
      category_ids << Category.find_or_create_by(name: name)&.id
    end
    course.category_ids = category_ids
  end
end
