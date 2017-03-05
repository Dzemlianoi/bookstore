class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    super
  end

  def update_guest
    if user_had_order?
      current_user.orders.in_carting.destroy_all
      current_guest.orders.first.update(user: current_user)
    end
    current_guest.destroy
    cookies.delete :guest_token
    redirect_to order_step_path(id: :address)
  end

  def user_had_order?
    current_user.orders.in_carting.present? && !current_guest.orders.first.nil?
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:checkout, :attribute])
  end
end
