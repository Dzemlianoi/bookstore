class CartController < ApplicationController
  def update
    empty_cart? ? initialize_cart : add_one_more_book
    flash.keep
    redirect_back(books_path)
  end

  def index
    @books = cart_books.map{|k,v| {Book.find_by_id(k) => v}}.reduce(:merge).reject {|k, v| k.nil? || v.to_i <= 0}
    byebug
    render and return unless empty_cart?
    flash[:error] = t('flashes.error.empty_cart')
    redirect_back(root_path)
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

  def empty_cart?
    !cookies.key? :cart
  end

  def add_one_more_book
    return error if cart_books.key? params[:id]
    cookies[:cart] = JSON.generate(cart_books.reverse_merge!(hash_params))
    success
  end

  def permitted_options
    params.require(:book).permit(:quantity)
  end

  def cart_books
    JSON.parse(cookies[:cart])
  end

  def error
    flash[:danger] = t('flashes.error.already_persist')
  end

  def success
    flash[:success] = t('flashes.success.book_added')
  end
end
