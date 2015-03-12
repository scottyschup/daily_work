class GuessGame

  def initialize
    @correct_number = (1..100).to_a.sample
    @guesses = 0
  end

  def run
    correct = false
    until correct
      get_guess
      correct = evaluate_guess
    end
    puts "You win! It was #{@correct_number}"
  end

  def evaluate_guess()
    return true if @guess == @correct_number
    puts @guess > @correct_number ? "Too high" : "Too low"
    false
  end

  def get_guess
    print "Guess a number between 1 and 100: "
    @guess = gets.chomp.to_i
    @guesses += 1
  end
end

class FileShuffler

  def initialize(filename)
    @filename = filename
    @file = File.readlines(filename)
    save_file
  end

  def shuffle_lines
    @file.shuffle
  end

  def save_file
    f = File.open("#{@filename}-shuffled.txt", "w")
    shuffle_lines.each do |line|
      f.puts line
    end
    f.close
  end
end
