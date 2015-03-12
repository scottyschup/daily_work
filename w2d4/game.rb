require_relative 'player'
require_relative 'board'

class Game
  attr_reader :board, :current_player, :players
  attr_accessor :winner, :turn

  def initialize(player1, player2, board = Board.new)
    @board = board
    @players = {
      red: player1,
      black: player2
    }
    assign_colors_board
    @turn = player1
    run
  end

  def assign_colors_board
    players.each do |kolor, player|
      player.color = kolor
      player.board = board
    end
  end

  def run
    board.display
    players.each { |color, player| puts "#{player.name} is #{color}.\n"}
    status

    until won?

      board.display
      status
      turn.make_move
      toggle_turn

      # autosave?
    end

    end_game
  end

  def status
    puts "It's #{turn.name}'s turn.\n"
  end

  def toggle_turn
    @turn = @turn.color == :red ? players[:black] : players[:red]
  end

  def won?
    if board.all_pieces[:red].empty?
      @winner = players[:black]
      return true
    elsif board.all_pieces[:black].empty?
      @winner = players[:red]
      return true
    else

    false
    end
  end

  def end_game
    board.display
    puts "Congratulations #{winner.name}!"
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new(ComputerPlayer.new, ComputerPlayer.new)
end
