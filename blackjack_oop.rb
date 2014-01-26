class Card
  attr_accessor :value

  def initialize (v)
    @value = v
  end

  def to_s
    "#{value}"
  end

  def get_value
    @value
  end
end

class Deck
  attr_accessor :card_deck

  def initialize
    @card_deck = []
    ['Ace','Jack','King','Queen',2,3,4,5,6,7,8,9,10].each do |card|
      4.times do
        card_deck << Card.new(card)
      end
    end
    card_deck.shuffle!
  end

  def to_s
    "#{@card_deck}"
  end

end

class Player

  attr_accessor :name, :point, :cards

  def initialize (name)
    @name = name
    @point = 0
    @cards = []

  end

  def show_cards
    "#{cards}"
  end

  def set_total_point
    sum = 0
    repetition = 0
    @cards.each do |card|
      if card.get_value == 'Ace'
        sum += 11
      elsif card.get_value.to_i == 0
        sum = sum + 10
      else 
        sum = sum + card.get_value
      end
    end

    repetition = @cards.select{|value| value == 'Ace'}.count
    repetition.times do
      if sum > 21
        sum -= 10
      end
    end
    @point = sum 
  end

  def hit(deck_card)
    @cards << deck_card.pop
  end
end

class Dealer < Player
end

class Game_Play

  def initialize name
    @play_deck = Deck.new
    @player_one = Player.new(name)
    @dealer_one = Dealer.new("Dealer One")
    @player_one.cards << @play_deck.card_deck.pop
    @player_one.cards << @play_deck.card_deck.pop
    @dealer_one.cards << @play_deck.card_deck.pop
    @dealer_one.cards << @play_deck.card_deck.pop
    @player_one.set_total_point
    @dealer_one.set_total_point
    puts "Your card : total point : #{@player_one.point}, card in hand: #{@player_one.show_cards}"
    puts "Dealer card : total point : #{@dealer_one.point}, card in hand: #{@dealer_one.show_cards}"
  end

  def game_start
    hos = 0
    while true
      if @player_one.point == 21
        puts "you win"
        hos = 1
        break
      elsif @dealer_one.point == 21
        puts "you lose"
        hos = 1
        break
      elsif @player_one.point > 21
        puts "you lose"
        hos = 1
        break
      end
      puts "what would you like to do 1)hit 2)stay"
      hit_or_stay = gets.chomp
      if hit_or_stay == "1"
        @player_one.hit(@play_deck.card_deck)
        @player_one.set_total_point
        puts "Your card : total point : #{@player_one.point}, card in hand: #{@player_one.show_cards}"
        puts "Dealer card : total point : #{@dealer_one.point}, card in hand: #{@dealer_one.show_cards}"
      elsif hit_or_stay == "2"
        break
      else
        puts "invalid input"
        next
      end
    end

    if hos == 1
      return
    end
    while @dealer_one.point < 17
      @dealer_one.hit(@play_deck.card_deck)
      @dealer_one.set_total_point
      puts "Your card : total point : #{@player_one.point}, card in hand: #{@player_one.show_cards}"
      puts "Dealer card : total point : #{@dealer_one.point}, card in hand: #{@dealer_one.show_cards}"
    end

    if @dealer_one.point > 21
      puts "you win"
      return
    elsif @dealer_one.point > @player_one.point
      puts "you lose"
      return
    elsif @player_one.point > @dealer_one.point
      puts "you win"
      return
    else
      puts "you guys draw"
      return
    end
  end
end

while true
  intput_check = 0
  one = Game_Play.new ("Moo")
  one.game_start
  puts "do you want to play again 1)yes 2)no"
  input = gets.chomp
  while true
    if input == "2"
      intput_check = 2
      break
    elsif input == "1"
      intput_check = 1
      break
    else
      next
    end
  end
  if intput_check == 1
    next
  elsif intput_check == 2
    break
  end
end

puts "Thankyou for playing"