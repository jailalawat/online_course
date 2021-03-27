class CanvasCourseCourseJob < ApplicationJob
  queue_as :default

  def perform
    CanvasCourseService.new('https://www.canvas.net/products.json').call
  end
end
