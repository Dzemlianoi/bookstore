class CategoriesController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :books, through: :category
  def show
    @books = @category.books
  end
end
