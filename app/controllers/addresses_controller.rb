class AddressesController < ApplicationController
  def create
    @address = Address.create(address_params.merge(addressable:current_user))
    render 'devise/registrations/edit' if @address.errors
  end

  def update
    @address = current_user.addresses
                   .find_by_kind(address_params[:kind])
                   .update(address_params)
  end

  private

  def address_params
    params.require(:address).permit(
        :first_name, :last_name, :address,
        :city, :zip, :country, :phone, :kind
    )
  end
end
