class Delivery < ApplicationRecord
  has_many :orders

  validates_presence_of :title, :price, :pesimistic_days
  validates_numericality_of :pesimistic_days, :optimistic_days, only_integer: true
  validates_numericality_of :price, greater_than: 0, less_than: 1000
  validates_numericality_of :pesimistic_days, :optimistic_days,
                            greater_than: 0,
                            less_than: 31
  validates_format_of :price, with: /\A\d+(?:\.\d{0,2})?\z/
  validates_format_of :title,
                      with: /\A[-a-z0-9, !?&.]+\z/i,
                      message: I18n.t('flashes.error.wrong_title_delivery')
  validate :pesimistic_greater_optimistic

  def pesimistic_greater_optimistic
    return if pesimistic_days > optimistic_days
    errors.add(:optimistic_days, I18n.t('flashes.error.wrong_days_delivery'))
  end
end
