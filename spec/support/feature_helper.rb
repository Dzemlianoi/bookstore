module FeatureHelper
  def sign_in(user, location = nil)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'user_password', with: user.password
    first('[name = commit]').click
    visit(location) if location
  end

  def fill_review(review)
    fill_in 'review_name', with: review.name
    fill_in 'review_comment_text', with: review.comment_text
    first('.star-cb-group label[for = rating-5]').click
    first("[value = #{I18n.t('books.reviews.post')}]").click
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