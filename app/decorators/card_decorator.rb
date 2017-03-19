class CardDecorator < Draper::Decorator
  delegate_all

  def private_show
    ('**** ' * 3) << object.card_number[-4, 4]
  end
end