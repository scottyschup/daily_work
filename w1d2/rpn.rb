# require 'byebug'
class RPN
  @@operands = {
    :+ => '+',
    :- => '-',
    :* => '*',
    :/ => '/'
  }

  def initialize
    @sequence = []
  end

  def add(x, y)
    x + y
  end

  def subtract(x, y)
    x - y
  end

  def multiply(x, y)
    x * y
  end

  def divide(x, y)
    x / y
  end

  def run
    get_input
    calculate
  end

  def calculate
    result = []
    @sequence.each do |el|
      if @@operands.has_value?(el)
        y = result.pop.to_f
        x = result.pop.to_f
        result << case(el)
        when '+'
          add(x, y)
        when '-'
          subtract(x, y)
        when '*'
          multiply(x, y)
        when '/'
          divide(x, y)
        end
      else
        result << el
      end
    end
    result
  end

  def get_input
    puts "Enter file name or press enter."
    @filename = gets.chomp
    if @filename.empty?
      @finished_input = false
      puts "Enter operands and operators one at a time:\n"
      until @finished_input
        get_operand
      end
    else
      get_from_file
    end
  end

  def get_from_file
    @sequence = File.readlines(@filename)[0].gsub(/\\n/, '').split(' ')
  end

  def get_operand
    # debugger
    input = gets.chomp

    if input.empty?
      @finished_input = true
    else
      @sequence << input
    end
    @sequence
  end


end
#
# if __FILE__ == $PROGRAM_NAME
#   RPN.new.run
# else
#
# end
