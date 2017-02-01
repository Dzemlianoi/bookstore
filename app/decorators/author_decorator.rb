class AuthorDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.surname} #{object.name}"
  end
end