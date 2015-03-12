require_relative 'piecesupers'

class Rook < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
    @symbol = :R
  end

  def valid_moves_list
    get_valid_moves_from(ORTHOGONAL_MOVES)
  end
end

class Bishop < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = :B
  end

  def valid_moves_list
    get_valid_moves_from(DIAGONAL_MOVES)
  end
end

class Queen < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = :Q
  end

  def valid_moves_list
    get_valid_moves_from(ORTHOGONAL_MOVES + DIAGONAL_MOVES)
  end
end

class Knight < SteppingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = :N
  end

  def valid_moves_list
    get_valid_moves_from(KNIGHT_MOVES)
  end
end

class King < SteppingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
    @symbol = :K
  end

  def valid_moves_list
    get_valid_moves_from(ORTHOGONAL_MOVES + DIAGONAL_MOVES)
  end
end

class Pawn < ChessPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
    @symbol = :P
  end

  def valid_moves_list
    if @color == :white
      get_valid_moves_from(WHITE_PAWN_MOVES)
    else
      get_valid_moves_from(BLACK_PAWN_MOVES)
    end
  end

  def test_direction(dx, dy)
    x, y = @pos
    test_pos = [x + dx, y + dy]

    if dx == 0
      if dy > 1
        [test_pos] if valid_move?(test_pos) && !@moved
      else
        [test_pos] if valid_move?(test_pos)
      end
    else
      [test_pos] if valid_kill?(test_pos)
    end
  end

  def valid_move?(pos)
    valid_target?(pos) && move_type(pos) == :move
  end

  def valid_kill?(pos)
    valid_target?(pos) && move_type(pos) == :kill
  end
end
