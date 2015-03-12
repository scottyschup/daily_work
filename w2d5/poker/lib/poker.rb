require_relative 'player'
require_relative 'deck'

# Game class for Poker
class Game
  attr_accessor :players, :deck, :discard_pile

  def initialize(players_arr, deck = nil)
    @players = players_arr
    @deck ||= Deck.new
    @discard_pile = Deck.new([])
    add_players_to_table
  end

  def add_players_to_table
    players.each { |player| player.game = self }
  end

  def run
    until players.count < 2
      play_round
    end
  end

  def play_round
  end
end
