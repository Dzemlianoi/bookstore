# frozen_string_literal: true

class AuthorDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.name} #{object.surname}"
  end
end
