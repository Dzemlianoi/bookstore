class BooksController < ApplicationController

  helper_method :book_params

  load_resource :category
  load_resource :book
  load_and_authorize_resource through: :category, only: :index, if: -> { !@category.nil? }
  load_and_authorize_resource only: :index, unless:  -> { !@category.nil? }

  def index
    @books = @books.order(ordering).page book_params[:page]
  end

  private

  def ordering
    order = (params.key? :order) ? params[:order].to_sym : nil
    (Book::ORDERING.key? order) ? Book::ORDERING[order] : Book.default_sort
  end

  def book_params
    params.permit(:page, :id, :order)
  end
end