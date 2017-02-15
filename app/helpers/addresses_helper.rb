module AddressesHelper
  def profile_address type
    current_user.addresses.where(kind: type).first
  end

  def form_details type
    return { method: :post, for: :address } if (profile_address type).nil?
    { method: :patch, for: profile_address(type) }
  end
end
