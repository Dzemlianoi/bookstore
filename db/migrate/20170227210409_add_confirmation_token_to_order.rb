# frozen_string_literal: true

class AddConfirmationTokenToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :confirmation_token, :string
  end
end
