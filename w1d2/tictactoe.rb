require 'byebug'

class Board
  attr_accessor :winning_mark

  @@possible_wins = [
    [:a1, :a2, :a3],
    [:b1, :b2, :b3],
    [:c1, :c2, :c3],
    [:a1, :b1, :c1],
    [:a2, :b2, :c2],
    [:a3, :b3, :c3],
    [:a1, :b2, :c3],
    [:a3, :b2, :c1]
  ]

  def initialize
    @board = {
      :a1 => '', :a2 => '', :a3 => '',
      :b1 => '', :b2 => '', :b3 => '',
      :c1 => '', :c2 => '', :c3 => ''
    }
  end

  def tie?
    !@board.values.include?('')
  end

  def won?
    @@possible_wins.each do |possible_win|
      if @board[possible_win[0]] == @board[possible_win[1]] &&
          @board[possible_win[1]] == @board[possible_win[2]] &&
          !@board[possible_win[0]].empty?
        return @winning_mark = @board[possible_win[0]]
      end
    end
    false
  end

  def empty_pos?(pos)
    @board[pos].empty?
  end

  def place_mark(pos, mark)
    if empty?(pos)
      @board[pos] = mark
    else
      false
    end
  end

  def display
    puts "#{@board[:a1]} | #{@board[:a2]} | #{@board[:a3]}"
    puts '---------'
    puts "#{@board[:b1]} | #{@board[:b2]} | #{@board[:b3]}"
    puts '---------'
    puts "#{@board[:c1]} | #{@board[:c2]} | #{@board[:c3]}"
  end
end

class Game

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.name |= 'Player 1'
    @player2.name |= 'Player 2'
    @player1.mark, @player2.mark = 'X', 'O'

    @board = Board.new
    @current_turn = true
    play
  end

  def play
    until @board.won? || @board.tie?
      @board.display
      take_turn
    end

    end_game
  end

  def take_turn
    player = @current_turn ? @player1 : @player2
    puts '--------------------------------'
    puts "#{player.name}, it's your turn!\n"
    until @board.place_mark(player.move, player.mark)
      puts "Invalid move." if player.class == HumanPlayer
    end
    @current_turn = !@current_turn
  end

  def end_game
    @board.display
    if @board.winning_mark.nil?
      puts "It's a tie!"
    else
      winner = @board.winning_mark == @player1.mark ? @player1 : @player2
      puts "Congratulations #{winner.name}"
    end
  end
end

class Player
  attr_accessor :mark, :name

  def initialize
    return
  end

end

class HumanPlayer < Player

  def initialize
  end

  def move
    puts "Choose a square: "
    pos = gets.chomp.to_sym
  end
end

class ComputerPlayer < Player
  def initialize
  end

  def move
    sleep(1.0 / 10.0)
    position = (['a','b','c'].sample + ['1', '2', '3'].sample).to_sym
  end
end
