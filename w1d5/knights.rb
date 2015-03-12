require 'byebug'
require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :visited_positions

  def initialize(start)
    @root = PolyTreeNode.new start
    @visited_positions = [start]
  end

  # Returns moves on the board
  def self.valid_moves(pos)
    coords = [1, -1, 2, -2]
    result = []

    coords.each do |x|
      coords.each do |y|
        result << [pos[0] + x, pos[1] + y] unless x.abs == y.abs
      end
    end

    result.keep_if do |coord|
      coord[0].between?(0, 7) && coord[1].between?(0, 7)
    end
  end

  def new_move_positions(pos)
    result = []
    self.class.valid_moves(pos).each do |move|
      result << move unless @visited_positions.include? move
    end
    @visited_positions += result
    result
  end

  def build_move_tree
    queue = [@root]

    until queue.empty?
      this_node = queue.shift
      new_move_positions(this_node.value).each do |position|
        new_node = PolyTreeNode.new(position)
        queue << new_node
        new_node.parent = this_node
      end
    end

  end

  def find_path(end_pos)
    @root.bfs(end_pos).trace_path_back
  end

end
