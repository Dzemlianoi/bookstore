class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    wrong_request and return unless @user.persisted?
    update_guest if current_guest
    redirect_to(success_redirect_location) if sign_in @user
    set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
  end

  private

  def failure
    redirect_to root_path
  end

  def wrong_request
    session['devise.facebook_data'] = request.env['omniauth.auth']
    location = fast_sign? ? order_step_path(id: :fast_sign) : new_user_registration_url
    redirect_to location
  end

  def success_redirect_location
    fast_sign? ? order_step_url(id: :address) : root_path
  end

  def update_guest
    @user.orders.in_carting.destroy_all if user_had_order? && guest_has_order?
    current_guest.orders.first.update(user: @user)
    destroy_guest if cookies[:guest_token]
  end

  def user_had_order?
    @user.orders.in_carting.present?
  end

  def guest_has_order?
    return unless current_guest
    current_guest.orders.present?
  end

  def destroy_guest
    current_guest.destroy
    cookies.delete :guest_token
  end

  def fast_sign?
    request.referer == order_step_url(id: :fast_sign)
  end
end