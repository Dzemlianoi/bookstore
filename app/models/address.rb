class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  enum type: [:billing, :shipping]
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :type, presence: true
end
