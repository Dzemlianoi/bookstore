class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :name, :rating, :comment_text, :book, :user
  validates_length_of :comment_text, maximum: 500
  validates_length_of :name, maximum: 80
  validates_format_of :comment_text, :with => /\A[-0-9A-z!#$%&_?+{|^} ]+\z/i
  validates :rating, inclusion: { in: 1..5 }
end
