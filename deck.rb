class Deck

  attr_accessor :cards

  SUITS={H: '♥', S:'♠', D:'♦', C:'♣'}
  CARDS={'A' => 1,'2' => 2,'3' => 3,'4' => 4,'5' => 5,'6' => 6,'7' => 7,'8' => 8,'9' => 9,'10' => 10,'J' => 10,'Q' => 10,'K' => 10}

  def initialize
    @cards = {}

    SUITS.each_value do |suit|
      CARDS.each do |card, points|
        @cards["#{suit} #{card}"] = points
      end
    end
  end
end