# frozen_string_literal: true

class DeleteVerifiedFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :verified
  end
end
