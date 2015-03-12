require_relative 'piecesupers'
require_relative 'pieces'

class Board
  BACK_ROW ||= [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  attr_accessor :board

  def initialize
    generate_board
  end

  def available?(pos)
    self[pos].nil?
  end

  def generate_board
    @board = Array.new(8) { Array.new(8) { nil } }
    populate_board
  end

  def on_board?(pos)
    x, y = pos
    board_range = (0..7)
    board_range.include?(x) && board_range.include?(y)
  end

  def populate_board
    pieces = []
    [[7, :black], [0, :white]].each do |y, color|
      BACK_ROW.each_with_index do |klass, x|
        pieces << klass.new([x, y], self, color)
      end
    end

    [[6, :black], [1, :white]].each do |y, color|
      (8).times do |x|
        pieces << Pawn.new([x, y], self, color)
      end
    end

    pieces.each { |piece| self[piece.pos] = piece }
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end
end
