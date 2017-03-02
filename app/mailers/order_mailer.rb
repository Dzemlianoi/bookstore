class OrderMailer < ApplicationMailer
  def confirmation_send(user, order)
    @order = order
    @user = user
    mail(to: @user.email,
         subject: 'Confirm your purchase',
         template_path: 'orders/mailers',
         template_name: 'confirm')
  end

  def treating_send(user,order)
    @order = order
    @user = user
    mail(to: @user.email,
         subject: 'Successfull purchase!',
         template_path: 'orders/mailers',
         template_name: 'treat')
  end

  def success_letter(user, order)
    @order = order
    @user = user
    mail(to: @user.email,
         subject: 'You order is in proccessing!',
         template_path: 'orders/mailers',
         template_name: 'success')
  end
end
