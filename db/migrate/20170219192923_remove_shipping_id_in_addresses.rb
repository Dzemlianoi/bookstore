# frozen_string_literal: true

class RemoveShippingIdInAddresses < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :shipping_address_id
    remove_column :orders, :billing_address_id
  end
end
