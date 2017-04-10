# frozen_string_literal: true

class AddDefaultQuantityInOrderItems < ActiveRecord::Migration[5.0]
  def change
    change_column :order_items, :quantity, :integer, default: 1
  end
end
