module AddressesHelper
  def address_form(kind)
    current_user.addresses.find_by_kind(kind) || @address || Address.new
  end

  def type_of? kind
    return unless @address
    @address.kind.eql? kind
  end
end
