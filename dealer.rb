require_relative 'player.rb'

class Dealer < Player

  def initialize(name = "Dealer")
    super
  end

  def decision(game)
    self.count_points
    if (self.points < 16 && game.finished == 0)
      print "Дилер взял карту.\n"
      self.take_cards(game)
    elsif (self.points > 21)
      game.finish
    elsif (game.finished == 1)
      print "Дилер вскрыл карты.\n"
    else
      print "Дилер пропускает ход.\n"
    end
  end

end