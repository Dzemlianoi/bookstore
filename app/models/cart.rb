class Cart
  def self.books_vs_quantity(cart)
    cart
        .map{|k,v| {Book.find_by_id(k) => v}}
        .reduce(:merge)
        .reject {|k, v| k.nil? || v.to_i <= 0}
  end

  def self.total_sum(cart)
    Cart.books_vs_quantity(cart).sum {|book, quantity| book.price * quantity.to_f}
  end
end