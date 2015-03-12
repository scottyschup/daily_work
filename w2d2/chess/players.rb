require 'byebug'

class Player
  NAMES = %w(Sterling Malory Lana Pam Cheryl Krieger Cyril Woodhouse)

  attr_accessor :name, :color, :board

  def initialize(name = nil)
    @name = name
  end

  def assign_name
    @name = NAMES.sample
    puts "You didn't give your name. I'll call you #{@name}."
  end

  def in_check?
    opponent_moves = ChessPiece.all_valid_moves(all_pieces(:opponent))
    opponent_moves.include?(king_position)
  end

  def in_checkmate?
    false # for now
  end

  def all_pieces(whose)
    color = whose == :own ? @color : opposite_color
    @board.board.flatten.compact.select { |piece| piece.color == color }
  end

  def king_position
    king = all_pieces(:own).select { |piece| piece.symbol == :K }

    return nil if king.empty?
    king[0].pos
  end

  def opposite_color
    @color == :white ? :black : :white
  end

  def set_color(color)
    @color = color
  end
end

class HumanPlayer < Player
  def request_input(type)
    if type == :source
      print "Enter location of piece (column_number row_number): "
    else
      print "Enter target position (column_number row_number): "
    end

    input_array = gets.chomp.split. # compact to catch nils before to_i
    input_array.map(&to_i)
  end
end

class ComputerPlayer < Player
  REINFELD_VALUES = {
    pawn: 1,
    bishop: 3,
    knight: 3,
    rook: 5,
    queen: 9,
    king: 1_000_000
  }

  def request_input(type)
    if type == :source
      pieces = @board.board.flatten.compact.select { |piece| piece.color == @color }
      moveable = pieces.select { |piece| piece.has_moves? }
      sleep(1.0 / 5)
      @this_move = moveable.sample
      @this_move.pos
    else
      sleep(1.0 / 10)
      @this_move.valid_moves_list.sample
    end
  end

end
