class Card < ApplicationRecord
  has_many :orders

  validates_presence_of :cvv, :expire_date, :card_number, :name
  validates_length_of :cvv, minimum: 4
  validates_length_of :name, maximum: 50
  validates_length_of :card_number, is: 12
  validates           :card_number, numericality: { only_integer: true }
  validates           :cvv, numericality: { only_integer: true }
  validates_format_of :name, :with => /\A[A-z ]+\z/i

  # def correct_expiration_date
  #   byebug
  #   expire_arr = expire_date.split('/')
  #   case
  #     when !expire_arr.count.eql? 2
  #       return errors.add(:expire_date, t('flashes.error.expire_slash'))
  #     when !expire_arr[0].to_i.between(1, 12) || !expire_arr[0].count.eql?(2)
  #       return errors.add(:expire_date, t('flashes.error.expire_month'))
  #     when expire_arr[1].to_i < Date.current.year.to_s.slice(-2,2).to_i
  #       return errors.add(:expire_date, t('flashes.error.expire_year'))
  #     else
  #       true
  #   end
  # end
end
