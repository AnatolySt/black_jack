require_relative 'bank.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'

class Game
  attr_accessor :player, :dealer, :bank, :deck, :item, :finished


  def initialize
    self.start_game
    @rate
  end

  def start_game
    puts "Начинаем игру в Блэк Джэк! Ваше имя?" unless defined? @player
    @player ||= Player.new(gets.chomp)
    @dealer ||= Dealer.new()
    @deck = Deck.new
    @bank = Bank.new
    2.times { @player.take_cards(self) }
    2.times { @dealer.take_cards(self) }
    @bank.start(self)
    @finished = 0
    self.show_info
    self.show_choice
    self.gaming_process
  end

  def gaming_process
    loop do
      self.select_choice
      case self.item
      when '1'
        puts "Вы пропустили ход!"
        @dealer.decision(self)
      when '2'
        @player.take_cards(self)
        @dealer.decision(self)
        self.show_info if self.finished == 0
        self.check_cards if self.finished == 0
      when '3'
        self.finish
      when 'Y'
        self.start_game
      when 'N'
        break
      end
    end
  end

  def show_info
    puts "Ваши очки: #{@player.points}"
    puts "Ваши карты: #{@player.show_cards}"
  end

  def show_choice
    if @finished == 0
      print "1. Пропустить \n"
      print "2. Добавить карту \n"
      print "3. Открыть карты \n"
    elsif @finished == 1
      print "Начать заново? (Y/N) \n"
    end
  end

  def select_choice
    puts 'Выберите действие'
    @item = gets.chomp
  end

  def check_cards
    self.finish if (@dealer.cards.to_a.size == 3 && @player.cards.to_a.size == 3)
  end

  def finish
    if @player.points > 21
      if @dealer.points > 21
        print "Ничья! У обоих игроков больше 21 очка\n"
        @bank.dead_heat(self)
      else
        print "Вы проиграли, у вас больше 21 очка\n"
        @bank.win(@dealer)
      end
    elsif @dealer.points > 21
      print "Вы выиграли! У дилера больше 21 очка\n"
      @bank.win(@player)
    elsif (@player.points > @dealer.points)
      print "Вы выиграли!\n"
      @bank.win(@player)
    elsif (@player.points < @dealer.points)
      print "Вы проиграли!\n"
      @bank.win(@dealer)
    end
    puts "Ваши очки: #{@player.points} | Ваши карты: #{@player.show_cards} | Ваши деньги: #{@player.money}"
    puts "Очки дилера: #{@dealer.points} | Карты дилера: #{@dealer.show_cards}"
    @finished = 1
    self.show_choice
    @player.cards = {}
    @dealer.cards = {}
  end
end
