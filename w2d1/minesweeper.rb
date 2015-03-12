require 'byebug'

class Tile
  attr_reader :pos, :board
  attr_accessor :value, :revealed, :flagged, :bombed

  def initialize(pos, board)
    @pos = pos
    @bombed = false
    @flagged = false
    @revealed = false
    @board = board
    @value = @board[@pos]
  end

  def reveal
    @revealed = true

    if @value == '*' # end_game
      @board.lost = true
    elsif @value > 0
      # @value = neighbor_bomb_count
      @board[@pos] = @value
    elsif @value == 0
      queue = [self]
      visited_tiles = [self]
      @board[@pos] = ' '
      until queue.empty?


        tile = queue.shift
        neighbor_tiles = tile.get_tile_neighbors

        neighbor_tiles.each do |neighbor|
          neighbor.revealed = true
          if neighbor.value > 0
            @board[neighbor.pos] = neighbor.value
          elsif neighbor.value == 0 && !visited_tiles.include?(neighbor)
            queue << neighbor
            visited_tiles << neighbor
            @board[neighbor.pos] = ' '
          end
        end

      end

    end
  end

  def get_tile_neighbors
    @board.tiles.select { |tile| self.neighbors.include?(tile.pos) }
  end

  def place_flag
    @revealed = true
    @flagged = true
    # @value = 'F'
    @board[@pos] = 'F'
  end

  def neighbors
    neighbors = []
    (-1..1).each do |i|
      (-1..1).each do |j|
        neighbor_pos = [@pos[0] + i, @pos[1] + j] unless i == 0 && j == 0
        neighbors << neighbor_pos if self.board.valid_tile?(neighbor_pos)
      end
    end

    neighbors
  end

  # def inspect
  #   "Bombed? #{@bombed} - Flagged? #{@flagged} - Revealed? #{@revealed}"
  # end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      count += 1 if @board.has_bomb?(neighbor) == true
    end

    count
  end
end

class Board
  attr_accessor :board, :lost, :won
  attr_reader :tiles

  def initialize(size, num)
    @size = size
    @board = Array.new(size) { Array.new(size) {'+'} }

    @coords_list = coords_list
    generate_bomb(num)

    @tiles = Array.new
    @won = @lost = false

    @coords_list.each do |coords|
      tile = Tile.new(coords, self)
      tile.value = @bomb_locations.include?(coords) ? '*' : 0
      @tiles << tile
    end

    @tiles.each do |tile|
      tile.value = tile.neighbor_bomb_count unless tile.value == '*'
    end

  end

  def valid_tile?(pos)
    return true if @coords_list.include?(pos)
    false
  end

  def generate_bomb(num)
    @bomb_locations = @coords_list.sample(num)
    # @bomb_locations.each { |pos| self[pos] = '*' }
  end

  def has_bomb?(pos)
    return true if @bomb_locations.include?(pos)
    false
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end

  def coords_list
    list = []
    @size.times do |row|
      @size.times do |col|
        list << [row, col]
      end
    end
    list
  end

  def get_move
    puts "Enter move: Mark X Y"
    gets.chomp
  end

  def handle_move(input)
    input = input.split(' ')

    mark = input[0]
    x = input[1].to_i
    y = input[2].to_i

    coords = [x, y]

    if mark.downcase == 'r'
      tile = @tiles.select { |tile| tile.pos == coords }
      tile.first.reveal
    elsif mark.downcase == 'f'
      tile = @tiles.select { |tile| tile.pos == coords }
      tile.first.place_flag
    end
  end

  def display_board
    (0..@size).to_a.each { |row| print "#{row} " }
    puts
    (0...@size).each do |row|
      (0...@size).each do |col|
        # pos = [row, col]
        if col == @size - 1
          print "#{self[[row, col]]}  "
          puts
        elsif col == 0
          print "#{self[[row, col]]}  "
        else
          print "#{self[[row, col]]}  "
        end
      end
    end
  end

  def won?
    @tiles.all? { |tile| tile.revealed == true }
  end

  def lost?
    @lost
  end

  def run
    until won? || lost?
      display_board
      handle_move(get_move)
      puts "Won: #{won?} | Lost: #{lost?}"
    end

    if won?
      puts "Congrats, you won!"
    elsif lost?
      puts "Damn, good luck next time!"
    end
  end

end

game = Board.new(9, 1)
game.run
