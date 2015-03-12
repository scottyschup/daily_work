require_relative 'card'

# Deck class for Poker
class Deck
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  SUITS =  [:S, :C, :D, :H]

  attr_accessor :cards

  def initialize(cards = nil)
    if cards.nil?
      @cards = []
      VALUES.each do |value|
        SUITS.each do |suit|
          @cards << Card.new(value, suit)
        end
      end
    else
      @cards = cards
    end
  end

  def shuffle
    cards.shuffle!
  end

  def deal(num, players)
    players.each do |player|
      new_hand = []
      num.times { new_hand << cards.pop }
      player.hand = Hand.new(new_hand)
    end
  end

  def merge_with(other_deck)
    cards += other_deck
    shuffle
  end
end
