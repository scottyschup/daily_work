require 'byebug'
def range(start, finish)
  return [] if start <= finish + 1
  [start.next] + range(start.next, finish)
end

class Array
  def recursive_sum
    return 0 if self.empty?
    self.first + self[1..-1].recursive_sum
  end

  def iter_sum
    sum = 0
    self.each { |el| sum += el }
    sum
  end

  def deep_dup
    self.map do |el|
      if el.is_a?(Array)
        Array.new(el).deep_dup
      else
        el
      end
    end
  end
  # this version of deep_dup can be written as a one-liner!
  # self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
end

def exp1(base, exponent) # takes exponent number of steps
  return 1 if exponent == 0
  base * exp1(base, exponent - 1)
  
  # one-liner: (exponent == 0) ? 1 : (base * exp1(base, exponent - 1))
end

def exp2(base, exponent)
  # exponent even/odd handle differently
  if exponent == 0
    1
  elsif exponent.even?
    exp2(base, exponent / 2)**2
  else
    base * (exp2(base, (exponent - 1) / 2)**2)
  end
end

def fib_seq_r(n)
  return [1] if n < 2

  prev_fibs = fib_seq_r(n - 1)

  next_num = prev_fibs.last(2).inject(:+)
  prev_fibs << next_num
end

def fib_seq_i(n)
  result = [0, 1]
  (n - 1).times do
    result << result[-1] + result[-2]
  end
  result[1..-1]
end


def bsearch(array, target)
  mid_point = (array.length) / 2
  pivot = array[mid_point]
  return mid_point if pivot == target

  if target < pivot
    left = array[0...mid_point]
    bsearch(left, target)
  else
    right = array[(mid_point + 1)..-1]
    (mid_point + 1) + bsearch(right, target)
  end
end

def make_change(n, coins)
  possible_combos = []
  coins.map do |coin|
    n / coin
  end
end
