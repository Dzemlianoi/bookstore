class ApplicationController < ActionController::Base

  helper_method :current_order

  include CanCan::ControllerAdditions

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  private

  def current_order
    return nil unless current_user
    current_user.orders.find_by(aasm_state: 'cart')
  end
end
