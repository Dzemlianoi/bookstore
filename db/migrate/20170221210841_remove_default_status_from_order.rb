# frozen_string_literal: true

class RemoveDefaultStatusFromOrder < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :aasm_state, :string, index: true
  end
end
