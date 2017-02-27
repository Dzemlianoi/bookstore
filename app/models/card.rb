class Card < ApplicationRecord
  has_many :orders

  validates_presence_of :cvv, :expire_date, :card_number, :name
  validates_length_of :cvv, minimum: 4
  validates_length_of :name, maximum: 50
  validates_length_of :card_number, is: 12
  validates_numericality_of :card_number, :cvv, only_integer: true
  validates_format_of :name, :with => /\A[A-z ]+\z/i
  validate :correct_expiration_date

  private

  def correct_expiration_date
    expire_arr = expire_date.split('/')
    case
      when !expire_arr.count.eql? 2
        errors.add(:expire_date, t('flashes.error.expire_slash'))
      when !expire_arr[0].to_i.between(1, 12) || !expire_arr[0].count.eql?(2)
        errors.add(:expire_date, t('flashes.error.expire_month'))
      when expire_arr[1].to_i < Date.current.year.to_s.slice(-2,2).to_i
        errors.add(:expire_date, t('flashes.error.expire_year'))
    end
  end
end
