class Bank

  attr_accessor :money, :rate

  def initialize
    @money = 0
    @rate = 10 # ставка
  end

  def start(game)
    game.player.money -= @rate
    game.dealer.money -= @rate
    @money = 2*(@rate)
  end

  def win(winner)
    winner.money += @money
    @money = 0
  end

  def dead_heat(game)
    game.player.money += @rate
    game.dealer.money += @rate
    @money = 0
  end

end