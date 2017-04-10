# frozen_string_literal: true

class AddVerifiedToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :verified, :boolean
  end
end
