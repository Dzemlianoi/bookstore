# frozen_string_literal: true

class ReviewDecorator < Draper::Decorator
  delegate_all

  def date
    time = object.created_at
    "#{time.day}/#{time.month}/#{time.year}"
  end

  def verified?
    return unless object.user
    object.user.verified?
  end
end
