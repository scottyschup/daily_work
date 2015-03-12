require 'set'

class ChessPiece
  ORTHOGONAL_MOVES ||= [
    [0,  1],
    [-1, 0],
    [0, -1],
    [1,  0]
  ]

  DIAGONAL_MOVES ||= [
    [1,   1],
    [1,  -1],
    [-1, -1],
    [-1,  1]
  ]

  # Bob Seger's been working on his
  KNIGHT_MOVES ||= [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  WHITE_PAWN_MOVES ||= [
    [-1, 1],
    [ 0, 1],
    [ 1, 1],
    [ 0, 2]
  ]

  BLACK_PAWN_MOVES ||= [
    [-1, -1],
    [ 0, -1],
    [ 1, -1],
    [ 0, -2]
  ]

  attr_accessor :pos, :symbol, :color

  def self.all_valid_moves(pieces)
    all_valid_moves_set = Set.new
    pieces.each do |piece|
      all_valid_moves_set += piece.valid_moves_list
    end
    all_valid_moves_set
  end

  # def all_pieces
  #   @board.board.flatten.compact.select { |piece| piece.color == color }
  # end

  # def self.which_piece?(pos)
  #   @board[pos]
  # end

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def get_valid_moves_from(move_deltas)
    valid_moves_list = []
    move_deltas.each do |dx, dy|
      this_dir = test_direction(dx, dy)
      valid_moves_list += this_dir unless this_dir.nil?
    end
    valid_moves_list
  end

  def has_moves?
    !valid_moves_list.empty?
  end

  def move(pos)
    @board[pos] = self
    @board[@pos] = nil
    @pos = pos
    @moved = true if [Rook, King, Pawn].include?(self.class)
  end

  def move_type(pos)
    if @board.available?(pos)
      :move
    elsif @board[pos].color != @color
      :kill
    end
  end

  def valid_target?(pos)
    if @board.on_board?(pos)
      if @board.available?(pos)
        return true
      elsif @board[pos].color != @color
        return true
      end
    end
    false
  end
end

class SlidingPiece < ChessPiece
  def test_direction(dx, dy)
    this_direction = []
    x, y = @pos
    test_pos = [x + dx, y + dy]

    while valid_target?(test_pos)
      this_direction << test_pos
      break if move_type(test_pos) == :kill
      x, y = test_pos
      test_pos = [x + dx, y + dy]
    end
    this_direction
  end
end

class SteppingPiece < ChessPiece
  def test_direction(dx, dy)
    x, y = @pos
    test_pos = [x + dx, y + dy]
    [test_pos] if valid_target?(test_pos)
  end
end
