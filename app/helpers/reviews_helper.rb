module ReviewsHelper
  def date(time)
    "#{time.day}/#{time.month}/#{time.year}"
  end

  def approved_reviews(book)
    book.reviews.where(approved: true)
  end

  def verified?(user)
    return if user.nil?
    user.verified.present?
  end
end
