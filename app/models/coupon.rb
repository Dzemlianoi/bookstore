# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :order

  validates_presence_of :code, :discount
  validates_uniqueness_of :code
  validates_length_of :code, minimum: 4, maximum: 40
  validates_numericality_of :discount, only_integer: true, greater_than: 0
  validates_uniqueness_of :order_id, unless: 'order_id.nil?'
end
