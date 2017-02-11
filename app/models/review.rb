class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :name, :rating, :comment_text, :book_id, presence: true
  validates :comment_text, length: { maximum: 1000 }
  validates :rating, inclusion: { in: 1..5 }

end
