class CategoriesController < ApplicationController
  def show
    case params[:id]
      when Category.default_category.id.to_s then redirect_to root_path
      when 'default' then @category = Category.default_category
      else @category = Category.find_by_id(params[:id].to_s)
    end
    @books = @category.books
  end
end
