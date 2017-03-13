class CategoriesController < ApplicationController
  load_and_authorize_resource :category, unless: -> { params[:id].eql? 'default' }

  def show
    case category_params[:id]
      when Category.default.id.to_s then redirect_to root_path and return
      when 'default' then @category = Category.default
    end
    @books = @category.books
  end

  private

  def category_params
    params.permit(:id)
  end
end
