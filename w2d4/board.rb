require 'colorize'
require_relative 'piece'

class Board
  attr_accessor :grid

  def self.on_board?(pos)
    x, y = pos
    board_range = (0..7)

    board_range.include?(x) && board_range.include?(y)
  end

  def self.space_between(one_pos, other_pos)
    x, y = one_pos
    x2, y2 = other_pos

    raise 'Not a valid move' unless (x - x2).abs == 2 && (y - y2).abs == 2
    [(x + x2) / 2, (y + y2) / 2]
  end

  def initialize(new_game = true)
    @grid = create_grid
    populate_grid if new_game == true
  end

  def create_grid
    Array.new(8) { Array.new(8) { nil } }
  end

  # def deep_dup
  #   dup_board = Board.new(new_game = false)
  #
  #   dup_board.grid.each_with_index do |row, y|
  #     row.each_with_index do |cell, x|
  #       dup_board[[x, y]] = cell.dup unless cell.nil?
  #     end
  #   end
  #
  #   dup_board
  # end

  def populate_grid
    start_rows = { red: (0..2), black: (5..7) }

    8.times do |x|
      8.times do |y|
        [:red, :black].each do |color|
          if (x + y).even? && start_rows[color].include?(y)
            self[[x, y]] = Piece.new(color, [x, y], self)
          end
        end
      end
    end

    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        puts "x=#{x}, y=#{y}, cell.class=#{cell.class}"
      end
    end
  end

  def display
    system 'clear'

    divider = '-' * ((8 * 4) + 1)
    cols = (0..7).to_a
    rows = (0..7).to_a.reverse

    cols.each { |num| print "  #{num} " }
    puts

    rows.each do |y|
      puts divider
      cols.each { |x| print render_square(x, y) }
      puts "| #{y}"
    end
    puts "#{divider}\n\n"
  end

  def render_square(x, y)
    this_square = self[[x, y]]
    bg_color = (x + y).odd? ? :cyan : :blue

    if this_square.nil?
      final_square = '   '.colorize(background: bg_color)
    else
      final_square = occupied(this_square, bg_color)
    end

    "|#{final_square}"
  end

  def occupied(piece, bg_color)
    piece_color, text_color = assign_colors(piece)

    if piece.king?
      symbol = :K.to_s.colorize(color: text_color, background: piece_color)
      space = ' '.colorize(color: text_color, background: piece_color)
    else
      symbol = :O.to_s.colorize(color: text_color, background: piece_color)
      space = ' '.colorize(background: bg_color)
    end

    space + symbol + space
  end

  def assign_colors(piece)
    if piece.color == :red
      piece_color, text_color = :red, :white
    else
      piece_color, text_color = :black, :white
    end
    [piece_color, text_color]
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def all_pieces
    hsh = { red: [], black: [] }

    spaces = grid.flatten
    spaces.each do |piece|
      unless piece.nil?
        hsh[piece.color] << piece
      end
    end

    hsh
  end
end
