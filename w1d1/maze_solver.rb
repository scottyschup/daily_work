require 'matrix'

class MazeSolver
  def initialize(maze)
    @maze = File.realines(maze).map { |row| row.split('') }
    @top, @left = 0, 0
    @bottom = maze.length
    @right = maze[0].length
  end

  def run
    explore(@maze)
    @path = [@start]
    until cell == @finish
      cell = make_choice(cell)
      @path << cell
    end
  end

  def explore
    @maze_map = Hash.new
    @maze.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        @maze_map["#{x}-#{y}"] = cell
        @pos = @start = [x, y] if cell == 'S'
        @finish = [x, y] if cell == 'E'
      end
    end
  end

  def make_choice
    @tried = []
    last_direction = direction(path[-1], @finish)
    first_choice = direction(@pos, @finish)

    case direction[0].abs <=> direction[1].abs
    when -1
      choice = direction[0] > 0 ? :right : :left
    when 0

    when 1
      choice = direction[1] > 0 ? :down : :up


  end

  def direction(here, there)
    here = Matrix.row_vector(path[-1])
    finish = Matrix.row_vector(@finish)
    direction = (finish - here).to_a[0]



  end

  def up(&alt)
    until @maze[@pos[0]][@pos[1]] == '*'
      @pos[0] -= 1

  end

  def down(&alt)

  end

  def right(&alt)

  end

  def left(&alt)

  end
end
