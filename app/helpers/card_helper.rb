module CardHelper
  def private_show(card_number)
    ('**** ' * 3) << card_number[-4, 4]
  end
end