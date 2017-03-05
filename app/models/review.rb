class Review < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :book

  validates_presence_of :name, :rating, :comment_text, :book, :user
  validates_length_of :comment_text, maximum: 500
  validates_length_of :name, maximum: 80
  validates_format_of :comment_text, :with => /\A[-0-9A-z!#$%&_?+{|^} ]+\z/i
  validates :rating, inclusion: { in: 1..5 }

  aasm column: 'state' do
    state :new, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: [:new, :rejected], to: :approved
    end

    event :reject do
      transitions from: [:new, :approved], to: :rejected
    end
  end

  rails_admin do
    list do
      field :state, :state
      include_all_fields
    end
    edit do
      field :state, :state
      include_all_fields
    end
  end
end
