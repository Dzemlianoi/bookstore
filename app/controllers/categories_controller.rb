class CategoriesController < ApplicationController
  load_and_authorize_resource :category, only: :show
  load_and_authorize_resource :books, through: :category, only: :show

  def show
    @books = @category.books
  end

  def default
    redirect_to Category.default
  end
end
