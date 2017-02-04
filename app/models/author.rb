class Author < ApplicationRecord
  has_many :books

  def full_name
    "#{self.name} #{self.surname}"
  end
end
