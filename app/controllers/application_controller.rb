class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  helper_method :current_order, :last_active_order

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
    return unless current_user
    current_user.orders.in_progress.order('created_at').last
  end

  def last_active_order
    return unless current_user
    current_user.orders.order('created_at').last
  end
end
