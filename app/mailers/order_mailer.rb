# frozen_string_literal: true

class OrderMailer < ApplicationMailer

  %w[confirmation treating success].each do |type|
    define_method "#{type}_send" do |user, order|
      @order = order
      @user = user
      mail(to: @user.email,
           subject: I18n.t("mailers.title.#{type}"),
           template_path: 'orders/mailers',
           template_name: type)
    end
  end
end
