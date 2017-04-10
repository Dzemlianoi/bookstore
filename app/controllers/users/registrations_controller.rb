class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = build_resource(sign_up_params)
    @user.set_fake_password if current_guest && fast_sign?
    yield resource if block_given?
    return unsaved_resource_response unless resource.save
    resource.active_for_authentication? ? active_response : inactive_response
  end

  protected

  def inactive_response
    set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    expire_data_after_sign_in!
    respond_with resource, location: after_inactive_sign_up_path_for(resource)
  end

  def active_response
    set_flash_message! :notice, :signed_up
    sign_up(resource_name, resource)
    update_guest if current_guest
    respond_with resource, location: success_redirect_location
  end

  def unsaved_resource_response
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end
end
