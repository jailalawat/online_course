# frozen_string_literal: true

class FutureLearnCourseJob < ApplicationJob
  queue_as :default

  def perform
    FutureLearnCourseService.new('https://www.futurelearn.com/feeds/courses').call
  end
end
