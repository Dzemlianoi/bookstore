module AddressesHelper
  def address_form(kind)
    right_kind(kind) || current_user.addresses.find_by_kind(kind) || Address.new
  end

  def right_kind(kind)
    return unless @address
    @address.kind.eql?(kind) ? @address : nil
  end
end

