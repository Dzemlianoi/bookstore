class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    update_guest if current_guest
    redirect_to order_step_path(id: :address) and return if params[:user][:checkout]
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
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

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:checkout, :attribute])
  end
end
