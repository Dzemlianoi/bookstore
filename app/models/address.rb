class Address < ApplicationRecord

  belongs_to :addressable, polymorphic: true
  has_one :order, foreign_key: 'shipping_address_id'
  has_one :order, foreign_key: 'billing_address_id'
  enum kind: [:billing, :shipping]

  scope :shipping_address,  -> { where(kind: 'shipping').first }
  scope :billing_address,   -> { where(kind: 'billing').first }

  validates_presence_of :first_name, :last_name, :address, :city, :zip, :country, :phone, :kind
  validates_inclusion_of :kind, in: Address.kinds.keys
  validates :first_name, length:  { maximum: 20 }

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name
  end
end
