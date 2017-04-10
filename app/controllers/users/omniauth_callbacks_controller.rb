# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    wrong_request && return unless @user.persisted?
    update_guest if current_guest
    redirect_to(success_redirect_location) if sign_in @user
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  end

  private

  def failure
    redirect_to root_path
  end

  def wrong_request
    session['devise.facebook_data'] = request.env['omniauth.auth']
    location = fast_sign? ? order_step_path(id: :fast_sign) : new_user_registration_url
    redirect_to location
  end
end
