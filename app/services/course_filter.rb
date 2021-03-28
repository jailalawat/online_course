class CourseFilter
  def initialize(params)
    @params = params
    @courses = Course.eager_load(:organisation, :categories, :images)
  end

  def call
    @course_arel = @courses.arel_table
    @category_arel = Category.arel_table
    filter_courses
  end

  private
  def filter_courses
    conditions
  end

  def conditions
    conditions_parts.each do |conditions_option|
      @courses = @courses.where(conditions_option)
    end
    @courses = @courses.page(@params[:page]).per(10)

    @courses
  end

  def categories_conditions
    category = @params[:category]
    if category.present?
      @category_arel[:name].eq(category)
    end
  end

  def provider_conditions
    provider = @params[:provider]
    if provider.present?
      @course_arel[:provider].eq(provider)
    end
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end
