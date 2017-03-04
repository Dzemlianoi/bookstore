class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  helper_method :current_order, :last_active_order, :current_user_or_guest

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def go_back
    redirect_back(fallback_location: root_path)
  end

  private

  def current_order
    return unless current_user_or_guest
    current_user_or_guest.orders.in_carting.order('created_at').last
  end

  def current_guest
    User.find_by(guest_token: cookies[:guest_token])  if cookies[:guest_token]
  end

  def current_user_or_guest
    current_user || current_guest
  end

  def last_active_order
    return unless current_user_or_guest
    current_user_or_guest.orders.order('created_at').last
  end
end
