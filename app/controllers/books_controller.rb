class BooksController < ApplicationController
  def index
    @categories = Category.where('count_books > 0').order('count_books DESC')
  end

  def show
  end
end
