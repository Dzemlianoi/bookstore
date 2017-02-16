class Address < ApplicationRecord

  belongs_to :addressable, polymorphic: true
  has_one :order, foreign_key: 'shipping_address_id'
  has_one :order, foreign_key: 'billing_address_id'
  enum kind: [:billing, :shipping]

  validates_presence_of :first_name, :last_name, :address, :city, :zip, :country, :phone, :kind
  validates :phone, :uniqueness => {
      :scope => [:addressable_type]
  }
  validates_inclusion_of :kind, in: Address.kinds.keys
  validates :first_name, length:  { maximum: 20 }
end
