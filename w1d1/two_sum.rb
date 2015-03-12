class Array
  def two_sum
    result = []

    (0...self.length).each do |i|
      (i + 1...self.length).each do |j|
        result.push([i, j]) if self[i] + self[j] == 0
      end
    end

    result
  end
end
