module FeatureHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'user_password', with: user.password
    first('[name = commit]').click
  end

  def add_book_to_cart(book)
    visit(book_path(book))
    click_add_to_cart
  end

  def click_add_to_cart
    within '#new_orders_item' do
      find('[type=submit]').click
    end
  end

  def visit_cart_with(book)
    add_book_to_cart(book)
    sleep 1
    visit cart_path
  end
end