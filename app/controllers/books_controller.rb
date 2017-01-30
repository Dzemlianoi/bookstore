class BooksController < ApplicationController
  def index
    @categories = Category.where('count_books > 0').order('count_books DESC')
    @books = Book.all.first(8)
  end

  def show
  end
end
