class BooksController < ApplicationController

  load_resource :category
  load_and_authorize_resource through: :category, only: :index, if: -> { !@category.nil? }
  load_and_authorize_resource only: :index, unless:  -> { !@category.nil? }

  def index
    @categories = Category.where('count_books > 0').order('count_books DESC')
    @books = @books.order(ordering).limit(8)
  end

  private

  def ordering
    order = params[:order].to_sym if params.key? :order
    return Book::ORDERING[order] if Book::ORDERING.key? order
    Book.default_sort
  end
end