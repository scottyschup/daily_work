class TowersOfHanoiGame
  attr_accessor :stacks

  def initialize
    @stacks = [[3,2,1], [], []]
  end

  def run
    until won?
      # prompt
      source = gets.chomp
      # input_validation

      # prompt
      goal = gets.chomp
      # input_validation

      move(source, goal)
    end

    puts "Congratulations!"
  end

  def move(source, goal)
    if stacks[goal].last.nil? || (stacks[goal].last > stacks[source].last)
      stacks[goal].push(stacks[source].pop)
    else
      raise "Invalid move!"
    end
  end

  def won?
    @stacks.include?([3, 2, 1]) && @stacks[0].empty?
  end

  def render
    @stacks.map {|array| array.map(&:to_s).join(' ')}.join("\n")
  end
end
