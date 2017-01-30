class BooksController < ApplicationController

  load_resource :category
  load_and_authorize_resource through: :category, only: :index

  def index
    @categories = Category.where('count_books > 0').order('count_books DESC')
  end
end
