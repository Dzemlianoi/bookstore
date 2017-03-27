class AddressesController < ApplicationController
  authorize_resource

  def create
    @address = current_user.addresses.create(address_params)
    render 'devise/registrations/edit' if @address.errors
  end

  def update
    @address ||= current_user.addresses
                   .find_by_kind(address_params[:kind])
                   .update(address_params)
    render 'devise/registrations/edit' and return unless @address
    redirect_to edit_user_registration_path
  end

  private

  def address_params
    params.require(:address).permit(
        :first_name, :last_name, :address,
        :city, :zip, :country, :phone, :kind
    )
  end
end
