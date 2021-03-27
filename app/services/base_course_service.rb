# frozen_string_literal: true

class BaseCourseService
  def initialize(url)
    api_url = url
    @response_json_datas = JSON.load(URI.open(api_url))
  end

  def call
    @response_json_datas.each do |json_data|
      course = create_course(json_data)
      if course.present?
        attach_images(json_data, course)
        create_categories(json_data, course)
      end
    end
  end
end
