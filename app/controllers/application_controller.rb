class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  helper_method :current_order, :last_active_order, :current_user_or_guest

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def go_back
    redirect_back(fallback_location: root_path)
  end

  protected

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

  protected

  def current_order
    return unless current_user_or_guest
    current_user_or_guest.orders.in_carting.newest.first
  end

  def current_guest
    User.find_by(guest_token: cookies[:guest_token]) if cookies[:guest_token]
  end

  def current_user_or_guest
    current_user || current_guest
  end

  def last_active_order
    return unless current_user_or_guest
    current_user_or_guest.orders.order('created_at').last
  end
end
