class AddAasmStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string, default: 'cart'
  end
end
