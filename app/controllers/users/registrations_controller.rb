class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = build_resource(sign_up_params)
    @user.set_fake_password if current_guest && fast_sign?
    yield resource if block_given?
    if resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
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
end
