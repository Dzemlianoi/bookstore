# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def facebook_reg(user, password)
    @password = password
    @user = user
    mail(to: @user.email,
         subject: 'Credential information',
         template_path: 'users/mailers',
         template_name: 'facebook_registration')
  end
end
