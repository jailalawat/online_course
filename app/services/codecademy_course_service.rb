# frozen_string_literal: true

require 'open-uri'

class CodecademyCourseService
  def initialize
    api_url = 'https://www.codecademy.com/catalog/all.json'
    @response_json_datas = JSON.load(URI.open(api_url))['entities']['paths']['byId']
  end

  def call
    @response_json_datas.each do |_key, json_data|
      course = create_course(json_data)
      if course.present?
        attach_images(json_data, course)
        create_categories(json_data, course)
      end
    end
  end

  private

  def create_course(json_data)
    Course.find_or_create_by!(title: json_data['title']) do |ce|
      ce.source_id = json_data['id'],
                     ce.description = json_data['description'],
                     ce.short_description = json_data['short_description'],
                     ce.organisation_id = create_organisation(json_data).id
    end
  end

  def create_organisation(json_data)
    name = json_data['organization_id']
    Organisation.find_or_create_by(name: name) if name.present?
  end

  def attach_images(json_data, course)
    img_url = json_data['splash_image']['url']
    if img_url =~ URI::DEFAULT_PARSER.make_regexp
      _url = URI.open(img_url)
      primary_image = course.images.build(primary: true)
      primary_image.image.attach(io: _url, filename: 'primary_image.jpg')
      primary_image.save
    end
  rescue Exception => e
    p e.message
  end

  def create_categories(json_data, course)
    category_ids = []
    json_data['content_item_type_counts'].each do |name, _v|
      category_ids << Category.find_or_create_by(name: name)&.id
    end
    course.category_ids = category_ids
  end
end
