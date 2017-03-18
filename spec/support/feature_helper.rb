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

  def click_add_to_cart
    within '#new_orders_item' do
      find('[type=submit]').click
    end
  end

  def fill_address(type, options)
    within ".#{type}_form" do
      fill_in I18n.t('users.addresses.first_name.placeholder'), with: options[:first_name]
      fill_in I18n.t('users.addresses.last_name.placeholder'), with: options[:last_name]
      fill_in I18n.t('users.addresses.address.placeholder'), with: options[:address]
      fill_in I18n.t('users.addresses.city.placeholder'), with: options[:city]
      fill_in I18n.t('users.addresses.zip.placeholder'), with: options[:zip]
      fill_in I18n.t('users.addresses.phone.placeholder'), with: options[:phone]
      first('input[type=submit]').click
    end
  end

  def fill_address_checkout(type, options)
    find("##{type}_first_name").set options[:first_name]
    find("##{type}_last_name").set options[:last_name]
    find("##{type}_address").set options[:address]
    find("##{type}_city").set options[:city]
    find("##{type}_zip").set options[:zip]
    find("##{type}_phone").set options[:phone]
    first('input[type=submit]').click
  end
end