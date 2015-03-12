require 'colorize'
require_relative 'players'
require_relative 'board'
require_relative 'errors'

class Game
  attr_reader :board, :turn, :player1, :player2

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.set_color(:white)
    @player2.set_color(:black)
    @turn = @player1
    build_board
    display
    run
  end

  def board_orientation
    nums = (0..7).to_a

    if @turn == @player2 && @player2.class == HumanPlayer
      rows = nums
      cols = nums.reverse
    else
      rows = nums.reverse
      cols = nums
    end
    [cols, rows]
  end

  def build_board
    @board = Board.new
    players.each { |player| player.board = @board }
  end

  def display
    system 'clear'

    ### testing for check
    players.each { |player| puts "#{player.name}: #{player.in_check?}" }

    divider = '-' * ((8 * 4) + 1)
    cols, rows = board_orientation

    cols.each { |num| print "  #{num} " }
    puts

    rows.each do |y|
      puts divider
      cols.each { |x| print render_square(x, y) }
      puts "| #{y}"
    end
    puts "#{divider}\n\n"
  end

  def end_game
    @board.board.flatten.compact.each do |piece|
      if piece.class == King
        winner = @player1.color == piece.color ? @player1 : @player2
        puts message = "Congratulations #{winner.name}!"
        break
      end
    end
  end

  def input_validation(options)
    if options[:target].empty?
      source = options[:source]

      if !source.is_a?(Array) || !source.length == 2
        raise UserInputError.new, 'Enter two numbers separated by a space'

      elsif !source[0].is_a?(Fixnum) || !source[1].is_a?(Fixnum)
        raise UserInputError.new, 'Both values must be integers'

      elsif @board.available?(source)
        raise UserInputError.new, 'There is not a piece there'

      elsif @turn.color != @board[source].color
        raise UserInputError.new, "It's #{@turn.color}'s move"

      elsif @board[source].valid_moves_list.empty?
        raise UserInputError.new, 'That piece has no valid moves'
      end
    else
      target, source = options[:target], options[:source]

      if !target.is_a?(Array)
        raise UserInputError.new, 'Enter two numbers separated by a space'

      elsif !@board[source].valid_moves_list.include?(target)
        raise UserInputError.new, 'That is not a valid move'
      end
    end
  end

  def players
    [@player1, @player2]
  end

  def render_square(x, y)
    this_cell = @board[[x, y]]
    bg_color = (x + y).odd? ? :cyan : :blue
    if this_cell.nil?
      square = '   '.colorize(background: bg_color)
    else
      piece_color, text_color = assign_colors(this_cell)
      space = ' '.colorize(background: bg_color)
      piece = "#{this_cell.symbol}".colorize(
        color: text_color, background: piece_color
      )
      square = space + piece + space
    end

    "|#{square}"
  end

  def request_move
    puts "#{@turn.name}'s turn. (#{@turn.name} is #{@turn.color}.)"

    input = { source: [], target: [] }
    [:source, :target].each do |key|
      begin
        input[key] = @turn.request_input(key)
        input_validation(input)
      rescue UserInputError => e
        puts "#{e}: please try again.\n\n"
        retry
      end
    end

    input.values
  end

  def run
    players.each { |player| player.assign_name if player.name.nil? }

    puts "#{@player1.name} is white, #{@player2.name} is black."
    puts "May the best player win!\n\n"

    # game loop
    until won?
      turn_loop
      # autosave using YAML (lowest priority)
    end

    system 'clear'
    display
    end_game
  end

  def assign_colors(piece)
    if piece.color == :white
      piece_color, text_color = :white, :red
    else
      piece_color, text_color = :black, :white
    end
    [piece_color, text_color]
  end

  def toggle_turn
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def turn_loop
    source, target = request_move
    @board[source].move(target)
    toggle_turn
    display
  end

  def won?
    players.each { |player| return true if player.king_position.nil? }
    players.each { |player| return true if player.in_checkmate? }

    false
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = ComputerPlayer.new
  p2 = ComputerPlayer.new

  game = Game.new(p1, p2)

  game.run
end
