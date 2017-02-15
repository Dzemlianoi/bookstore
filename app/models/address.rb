class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  enum kind: [:billing, :shipping]

  validates_presence_of :first_name, :last_name, :address, :city, :zip, :country, :phone, :kind
  validates :first_name, length:  { maximum: 20 }
end
