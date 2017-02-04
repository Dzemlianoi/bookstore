class BooksController < ApplicationController

  helper_method :permitted_params, :next_per

  load_resource :category
  load_and_authorize_resource through: :category, only: :index, if: -> { !@category.nil? }
  load_and_authorize_resource only: :index, unless:  -> { !@category.nil? }

  def index
    @books = @books.order(ordering).limit(limiting)
  end

  def show
    @book = Book.find_by_id(params[:id].to_s)
  end

  private

  def ordering
    order = (params.key? :order) ? params[:order].to_sym : nil
    (Book::ORDERING.key? order) ? Book::ORDERING[order] : Book.default_sort
  end

  def current_limit
    limit = params[:per].to_i
    limit.positive? ? limit : 1
  end

  def limiting
    current_limit * Book::PER_PAGE
  end

  def next_per
    current_limit + 1
  end

  def permitted_params
    params.permit(:per, :order)
  end
end