class AddressesController < ApplicationController

  def create
    @address = Address.new(address_params.merge(addressable:current_user)).save
    after_save(@address)
  end

  def update
    @address = current_user.addresses
                   .find_by_kind(address_params[:kind])
                   .update(address_params)
    after_save(@address)
  end

  private

  def after_save(result)
    if result
      flash[:success] = 'Address was changed successfuly'
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = 'Something went wrong, check all the fields'
      render 'devise/registrations/edit'
    end
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind)
  end
end
