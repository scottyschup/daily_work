require_relative 'tic_tac_toe'

class TicTacToeNode
  PLACES ||= (0..2).map { |x| (0..2).map { |y| [x, y] } }.flatten(1)

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @current_mover_mark = @next_mover_mark == :x ? :o : :x
    @prev_move_pos = prev_move_pos
    # @children = children
  end

  def losing_node?(evaluator)
    return true if @board.won? && @board.winner? != evaluator.to_sym


  end

  def winning_node?(evaluator)
    return true if @board.winner? == evaluator.to_sym


  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    results = []
    PLACES.each do |place|
      if @board.empty?(place)
        board = @board.dup
        board[place] = @next_mover_mark
        results << TicTacToeNode.new(board, @current_mover_mark, place)
      end
    end
    results
  end
end
