class CoursesController < ApplicationController
  def index
    courses = CourseFilter.new(params).call
    render json: {
      courses: BulkSerializer.new(
                  object: courses,
                  serializer: CourseSerializer
                ),
      next_page: courses.next_page
    }
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        course = Course.friendly.find(params[:id])
        render json: course
      }
    end
  end
end
