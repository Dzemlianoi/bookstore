class ReviewDecorator < Draper::Decorator
  delegate_all

  def date
    time = object.created_at
    "#{time.day}/#{time.month}/#{time.year}"
  end

  def verified?
    !!object.user(&:verified?)
  end
end