# frozen_string_literal: true

class CategoriesController < ApplicationController
  load_and_authorize_resource :category, only: :show
  load_and_authorize_resource :books, through: :category, only: :show

  def show
    @newest_books = @category.books.newest(3).decorate
    @bestsellers_books = @category.books.bestsellers(4).decorate
  end

  def default
    redirect_to Category.default
  end
end
