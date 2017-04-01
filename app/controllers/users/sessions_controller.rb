class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    update_guest if current_guest
    redirect_to order_step_path(id: :address) and return if params[:user][:checkout]
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:checkout, :attribute])
  end
end
