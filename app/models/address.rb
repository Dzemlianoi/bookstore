class Address < ApplicationRecord

  belongs_to :addressable, polymorphic: true
  has_one :order, foreign_key: 'shipping_address_id'
  has_one :order, foreign_key: 'billing_address_id'
  enum kind: [:billing, :shipping]

  scope :shipping_address,  -> { where(kind: 'shipping').first }
  scope :billing_address,   -> { where(kind: 'billing').first }

  validates_presence_of :first_name, :last_name, :address, :city,
                        :zip, :country, :phone, :kind
  validates_length_of :first_name, :last_name, :address, :city,  maximum: 50
  validates_length_of :zip, maximum: 10
  validates_length_of :phone, maximum: 15
  validates_format_of :first_name, :last_name, :city, :with => /\A[a-z]+\z/i
  validates_format_of :first_name, :last_name, :city, :with => /\A[a-z]+\z/i
  validates_format_of :zip, :with => /\A[-0-9]+\z/
  validates_format_of :address, :with => /\A[-a-z0-9, ]+\z/i
  validates_format_of :phone, :with => /\A[+]{1}[0-9]{8,14}\z/
  validates_inclusion_of :kind, in: kinds.keys
  validates_uniqueness_of :kind, scope: [:addressable_id, :addressable_type]

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name
  end
end
