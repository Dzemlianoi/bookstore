class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]

  def create
    @user = build_resource(sign_up_params)
    @user.set_fake_password if current_guest && fast_sign?
    yield resource if block_given?
    if resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        byebug
        update_guest if current_guest
        respond_with resource, location: success_redirect_location
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
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
