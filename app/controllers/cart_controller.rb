class CartController < ApplicationController
  def update
    first_buy? ? initialize_cart : add_one_more_book
    flash.keep
    redirect_back(fallback_location: books_path)
  end

  def index
    flash[:warning] = t('flashes.error.empty_cart')
    flash.keep
    redirect_back(fallback_location: root_path)
  end

  private

  def hash_params
    {params[:id] => quantity}
  end

  def quantity
    return 1 unless params.key? :quantity
    permitted_options[:quantity]
  end

  def initialize_cart
    cookies[:cart] = JSON.generate(hash_params)
  end

  def first_buy?
    !cookies.key? :cart
  end

  def add_one_more_book
    cart = JSON.parse(cookies[:cart])
    return error if cart.key? params[:id]
    cookies[:cart] = JSON.generate(cart.reverse_merge!(hash_params))
    success
  end

  def permitted_options
    params.require(:book).permit(:quantity)
  end

  def error
    flash[:danger] = t('flashes.error.already_persist')
  end

  def success
    flash[:success] = t('flashes.success.book_added')
  end
end
