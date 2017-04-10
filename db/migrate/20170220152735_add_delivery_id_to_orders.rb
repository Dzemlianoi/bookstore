# frozen_string_literal: true

class AddDeliveryIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :delivery, index: true
    add_reference :orders, :card, index: true
  end
end
