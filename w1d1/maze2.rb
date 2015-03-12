class Maze
  attr_accessor :start, :finish, :pos
  attr_reader :good_moves, :map, :path

  def initialize(file)
    @maze = File.readlines(file).map { |row| row.split('') }
    @map = explore
    @path = []
  end

  def explore
    @empty_spaces = 0
    @maze.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        @start = Coordinates.new(x, y) if cell == "S"
        @finish = Coordinates.new(x, y) if cell == "E"
      end
    end
  end

  def is_wall?(pos)
    self[pos] == '*'
  end

  def good_moves
    @path.empty? ? pos = @start.dup : pos = @path.last.dup
    [].tap do |result|
      result << directions.map do |dir|
        pos.dup.map(&dir) unless @path.include? pos.dup.map(&dir)
      end
    end
  end

  def directions
    [
      Proc.new(&:right),
      Proc.new(&:left),
      Proc.new(&:down),
      Proc.new(&:up)
    ]
  end
end

class Coordinates
  DELTA ||= [[0, 1], [0, -1], [1, 0], [-1, 0]] # right left down up

  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = [x, y]
  end

  def [](n)
    @x if n == 0
    @y if n == 1
    nil if n > 1 || n < 0
  end

  def []=(x, y)
    @x, @y = x, y
  end

  def right
    @x += DELTA[0][0]
    @y += DELTA[0][1]
    [@x, @y]
  end

  def left
    @x += DELTA[1][0]
    @y += DELTA[1][1]
    [@x, @y]
  end

  def down
    @x += DELTA[2][0]
    @y += DELTA[2][1]
    [@x, @y]
  end

  def up
    @x += DELTA[3][0]
    @y += DELTA[3][1]
    [@x, @y]
  end

  def map
    self
  end
end
#
# class MazeSolver
#
# end
