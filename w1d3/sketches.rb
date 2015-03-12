class Code

  def self.colors
    ["R", "G", "B", "Y", "O", "P"]
  end

  def self.secret_code
    secret = []
    4.times do
      secret << Code.colors.sample
    end
    secret
  end

  def initialize(input = Code.secret_code)
    @colors = input
  end

  def self.parse(colors)
    Code.new(colors.upcase.split('')) if colors.class == String
  end

  def matches(secret_code)
    exact_matches, near_matches = 0, 0
    unmatched_colors = @colors
    @colors.each_with_index do |color, index|
      if color == secret_code[index]
        exact_matches += 1
        unmatched_colors.delete_at(index)
        secret_code.delete_at(index)
      end
    end

    unmatched_colors.each do |guess|
      if secret_code.include? guess
        near_matches += 1
      end
    end
    puts "You have #{exact_matches} exact matches and #{near_matches} near matches."
    exact_matches
  end

end

class Game
  def initialize(secret_code = Code.secret_code)
    @secret_code = secret_code
    @user_guesses = []
  end

  def play
    secret_code = Code.secret_code
    iterations = 0

    while iterations < 10
      puts "Guess the computer's secret code!"
      input = gets.chomp
      @user_guesses[iterations] = Code.parse(input)

      if @user_guesses[iterations].matches(secret_code) == 4
        puts "You win!"
        break
      else
        iterations += 1
      end
    end
    puts "Computer wins"
  end

end
