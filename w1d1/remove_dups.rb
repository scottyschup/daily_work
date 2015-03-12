class Array
  def my_uniq
    arr = []

    self.each do |num|
      arr.push(num) unless arr.include?(num)
    end

    arr
  end
end
