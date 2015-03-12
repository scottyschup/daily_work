class Player
  NAMES ||= %w(Sterling Lana Mallory Woodhouse Pam Cheryl Cyril Krieger)

  attr_accessor :color, :board
  attr_reader :name

  def initialize(player_name = nil)
    @board = board
    if player_name.nil?
      @name = NAMES.sample
      puts "You didn't tell me your name, so I'll call you #{name}."
    else
      @name = player_name
      puts "Hello, #{name}!"
    end
  end
end

class ComputerPlayer < Player
  def make_move
    sleep(1.0 / 3)

    jumpers, sliders = [], []

    pieces = board.all_pieces
    pieces[color].each do |piece|
      if !piece.possible_jumps.empty?
        jumpers << piece
      elsif !piece.possible_slides.empty?
        sliders << piece
      end
    end

    if jumpers.empty?
      source = sliders.sample
      target = source.possible_moves[:slides].to_a.sample
      source.perform_slide!(target)
    else
      source = jumpers.sample
      target = source.possible_moves[:jumps].to_a.sample
      source.perform_jump!(target)
    end
  end
end
