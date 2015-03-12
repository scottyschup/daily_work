class Array
  def my_uniq
    self.each_with_object([]) do |el, result|
      result << el unless result.include?(el)
    end
  end

  def two_sum
    result = []
    length.times do |i|
      ((i + 1)...length).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end

    result
  end
end

def my_transpose(matrix)
  result = Array.new(matrix.length) { Array.new(matrix.length) }

  matrix.length.times do |row|
    matrix.length.times do |col|
      result[col][row] = matrix[row][col]
    end
  end

  result
end

def stock_picker(prices)
  max = 0
  max_idx = []

  prices.each_with_index do |start_price, start|
    prices[(start + 1) .. -1].each_with_index do |last_price, last|
      if (last_price - start_price) > max
        max_idx = [start, start + 1 + last]
        max = last_price - start_price
      end
    end
  end

  max_idx
end
