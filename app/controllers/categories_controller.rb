class CategoriesController < ApplicationController
  def show
    case category_params[:id]
      when Category.default.id then redirect_to root_path and return
      when 'default' then @category = Category.default
      else @category = Category.find_by_id(category_params[:id])
    end
    @books = @category.books
  end

  def category_params
    params.permit(:id)
  end
end
