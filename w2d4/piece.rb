require 'byebug'

class Piece
  # COLORS ||= [:red, :black]

  DIRECTIONS =   {
    red:   [[-1,  1], [1,  1]],
    black: [[-1, -1], [1, -1]]
  }

  attr_accessor :pos, :king, :board
  attr_reader :color

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @king = false
  end

  def king?
    king
  end

  def perform_slide!(target)
    move_to!(target)
  end

  def perform_jump!(target)
    jumped_piece = board[Board.space_between(pos, target)]
    jumped_piece.remove!

    move_to!(target)
  end

  def move_to!(target)
    board[pos] = nil
    self.pos = target
    board[target] = self

    if (pos[1] == 7 && color == :red) || (pos[1] == 0 && color == :black)
      self.king = true
    end
  end

  def remove!
    board[pos] = nil
  end

  def can_haz_slide?(direction)
    target = slide(direction)

    valid?(target)
  end

  def can_haz_jump?(direction)
    target = jump(direction)
    if valid?(target)
      intervening_space = Board.space_between(pos, target)

      return false unless Board.on_board?(intervening_space)
      return false if board[intervening_space].nil?
    end

    enemy?(board[intervening_space])
  end

  def slide(direction)
    dx, dy = direction
    x, y = pos
    [x + dx, y + dy]
  rescue
    debugger

  end

  def jump(direction)
    dx, dy = direction
    x, y = pos
    [x + (dx * 2), y + (dy * 2)]
  rescue
    debugger
  end
  #
  # def direction_to(other_pos)
  #   x, y = pos
  #   x2, y2 = other_pos
  #   [x2 - x, y2 - y]
  # end

  def possible_moves
    moves_hash = { slides: Set.new, jumps: Set.new }

    possible_slides.each { |move| moves_hash[:slides] << move }
    possible_jumps.each { |move| moves_hash[:jumps] << move }

    moves_hash
  end

  def possible_slides
    list = []
    directions = king? ? DIRECTIONS.values.flatten(1) : DIRECTIONS[color]

    directions.each do |direction|
      if valid?(slide(direction)) && can_haz_slide?(direction)
        list << slide(direction)
      end
    end

    list
  end

  def possible_jumps
    list = []
    directions = king? ? DIRECTIONS.values.flatten(1) : DIRECTIONS[color]

    directions.each do |direction|
      if valid?(jump(direction)) && can_haz_jump?(direction)
        list << jump(direction)
      end
    end

    list
  end

  def valid?(target)
    Board.on_board?(target) && available?(target)
  end

  def available?(target)
    board[target].nil?
  end

  def enemy?(other_piece)
    raise 'Houston we have a problem' if other_piece.class != Piece
    color != other_piece.color
  end
end
