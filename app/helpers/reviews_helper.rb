module ReviewsHelper
  def date(time)
    "#{time.day}/#{time.month}/#{time.year}"
  end

  def verified?(user)
    return if user.nil?
    user.orders.after_confirmation.present?
  end
end
