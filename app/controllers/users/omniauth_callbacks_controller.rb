class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    wrong_request and return unless @user.persisted?
    if cookies[:guest_token].present?
      update_guest_order
      sign_in_and_redirect_checkout
    else
      sign_in_and_redirect @user, :event => :authentication
    end
    set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end

  def wrong_request
    session['devise.facebook_data'] = request.env['omniauth.auth']
    redirect_to new_user_registration_url
  end

  def update_guest_order
    unless @user.orders.in_carting.nil?
      @user.orders.in_carting.last.order_items.delete_all
    end
    current_guest.update(guest_token: nil)
    current_guest.orders.first.update(user: @user)
    cookies.delete :guest_token
  end

  def sign_in_and_redirect_checkout
    sign_in @user, event: :authentication
    redirect_to order_step_path(id: :address)
  end
end