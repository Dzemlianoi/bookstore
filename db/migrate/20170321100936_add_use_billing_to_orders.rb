class AddUseBillingToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :use_billing, :boolean
  end
end
