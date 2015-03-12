require 'hand'

# Player class for Poker
class Player
  attr_accessor :bankroll, :hand, :game

  def initialize(bankroll, hand = nil)
    @bankroll = bankroll
    hand ||= Hand.new([])
    @hand = hand
  end

  def discard(card)
    game.discard_pile.cards << hand.cards.delete(card)
  end

  def card_count
    hand.cards.count
  end

  def make_bet(num)
    self.bankroll -= num
  end

  def fold
    game.discard_pile.cards += hand.cards
    hand.cards = []
  end
end
