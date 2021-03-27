class CodecademyCourseJob < ApplicationJob
  queue_as :default

  def perform
    CanvasCourseService.new.call
  end
end
