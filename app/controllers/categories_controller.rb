class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: {
      categories: BulkSerializer.new(
                  object: categories,
                  serializer: CategorySerializer
                )
    }
  end
end
