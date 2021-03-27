# frozen_string_literal: true

class CodecademyCourseJob < ApplicationJob
  queue_as :default

  def perform
    CodecademyCourseService.new.call
  end
end
