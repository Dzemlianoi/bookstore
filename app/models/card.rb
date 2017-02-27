class Card < ApplicationRecord
  has_one :order

  validates_presence_of :cvv, :expire_date, :card_number, :name
  validates_length_of :cvv, minimum: 3
  validates_length_of :name, maximum: 50
  validates_length_of :card_number, is: 16
  validates_numericality_of :card_number, :cvv, only_integer: true
  validates_format_of :name, with: /\A[A-z ]+\z/i
  validate :correct_expiration_date

  private

  def correct_expiration_date
    expire_arr = expire_date.split('/')
    case
      when expire_arr.count != 2
        errors.add(:expire_date, I18n.t('flashes.error.expire_slash')) and return
      when !expire_arr[0].to_i.between?(1, 12)
        errors.add(:expire_date, I18n.t('flashes.error.expire_month'))
      when expire_arr[1].to_i < Date.current.year.to_s.slice(-2,2).to_i
        errors.add(:expire_date, I18n.t('flashes.error.expire_year'))
    end
  end
end
