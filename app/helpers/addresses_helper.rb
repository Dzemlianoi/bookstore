# frozen_string_literal: true

module AddressesHelper
  def address_form(kind)
    right_kind(kind) || current_user.addresses.find_or_initialize_by(kind: kind)
  end

  def right_kind(kind)
    return unless @address
    @address.kind.eql?(kind) ? @address : nil
  end
end
