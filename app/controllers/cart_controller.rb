class CartController < ApplicationController

  helper_method :total_amount

  def update
    empty_cart? ? initialize_cart : add_one_more_book
    flash.keep
    redirect_back(fallback_location: books_path)
  end

  def index
    if !empty_cart?
      @books = Cart.books_vs_quantity(cart_books)
    else
      flash[:warning] = t('flashes.error.empty_cart')
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def hash_params
    {order_params[:id] => quantity}
  end

  def quantity
    order_params.key?(:book) ? order_params[:book][:quantity] : 1
  end

  def initialize_cart
    cookies[:cart] = JSON.generate(hash_params)
  end

  def empty_cart?
    !cookies.key? :cart
  end

  def add_one_more_book
    return error_flash if cart_books.key? order_params[:id]
    cookies[:cart] = JSON.generate(cart_books.reverse_merge!(hash_params))
    success_flash
  end

  def total_amount
    Cart.total_sum(cart_books)
  end

  def order_params
    params.permit(:id, book: [:quantity])
  end

  def cart_books
    JSON.parse(cookies[:cart])
  end

  def error_flash
    flash[:danger] = t('flashes.error.already_persist')
  end

  def success_flash
    flash[:success] = t('flashes.success.book_added')
  end
end
