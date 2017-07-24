class Player
  attr_accessor :money, :name, :cards, :points

  def initialize(name)
    @name = name
    @cards = {}
    @money = 100
  end

  def count_points # считаем количество очков исходя из полученных
    @points = 0
    @cards.each_value do |points|
      @points += 10 if (@points <= 10 && points == 1)
      @points += points.to_i
    end
  end

  def take_cards(game)
    @cards.merge!(game.deck.cards.to_a.sample(1).to_h)
    @cards.each_key do |player_card|
      game.deck.cards.delete_if {|key| key == player_card }
    end
    self.count_points
    game.finish if @points > 21
  end

  def show_cards
    @cards.keys.inspect
  end
end