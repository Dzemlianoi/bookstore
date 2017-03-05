class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    wrong_request and return unless @user.persisted?
    if cookies[:guest_token].present?
      convert_guest_order unless current_order.nil?
      destroy_guest
      sign_in_and_redirect_checkout
    else
      sign_in_and_redirect @user, :event => :authentication
    end
    set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
  end

  private

  def failure
    redirect_to root_path
  end

  def destroy_guest
    current_guest.destroy
    cookies.delete :guest_token
  end

  def wrong_request
    session['devise.facebook_data'] = request.env['omniauth.auth']
    redirect_to new_user_registration_url
  end

  def convert_guest_order
    @user.orders.in_carting.destroy_all if @user.orders.in_carting.present?
    current_guest.orders.first.update(user: @user)
  end

  def sign_in_and_redirect_checkout
    sign_in @user, event: :authentication
    redirect_to order_step_path(id: :address)
  end
end