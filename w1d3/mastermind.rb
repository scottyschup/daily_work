require 'byebug'
class Code
  PEGS = ["R", "G", "B", "Y", "O", "P"]

  attr_reader :pegs

  def self.random
    pegs = []
    4.times { pegs << PEGS.sample }

    Code.new(pegs)
  end

  def self.parse(pegs_string)
    Code.new(pegs_string.upcase.split(''))
  end

  def initialize(pegs)
    @pegs = pegs
  end

  def [](i)
    @pegs[i]
  end

  def pegs_string
    @pegs.join('-')
  end

  def compare(other_code)
    exact = exact_matches(other_code)
    near = near_matches(other_code, exact)

    [exact, near]
  end

  def exact_matches(other_code)
    exact = 0
    4.times do |i|
      exact += 1 if @pegs[i] == other_code[i]
    end

    exact
  end

  def near_matches(other_code, exact)
    near = 0
    pegs_counter, other_counter = {}, {}
    PEGS.each { |peg| pegs_counter[peg], other_counter[peg] = 0, 0 }

    @pegs.each do |peg|
      pegs_counter[peg] += 1
    end

    other_code.pegs.each do |peg|
      other_counter[peg] += 1
    end

    pegs_counter.each do |key, value|
      near += [value, other_counter[key]].min if other_counter.has_key?(key)
    end

    near - exact
  end
end

class Game
  def initialize(secret_code = Code.random)
    @secret_code = secret_code
    @guesses = []
  end

  def play
    10.times do
      @guesses << get_guess

      if @guesses.last.pegs == @secret_code.pegs
        puts "Congratulations! You got it in #{ @guesses.count } tries!"
        return
      end

      exact, near = @guesses.last.compare(@secret_code)
      display(exact, near)
    end
    puts "The secret code was #{@secret_code.pegs_string}. Computer wins :("
  end

  def get_guess
    puts "Guess the computer's secret code!"
    Code.parse(gets.chomp)
  end

  def display(exact, near)
    puts "Last guess: #{@guesses.last.pegs_string} Exact matches: #{exact} \
Near matches: #{near}"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
