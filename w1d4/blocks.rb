class Array
  def my_each
    self.count.times do |i|
      yield self[i]
    end
    self
  end

  def my_map
    result = []
    self.my_each do |el|
      result << yield(el)
    end
    result
  end

  def my_select
    result = []
    self.my_each do |el|
      result << el if yield(el)
    end
    result
  end

  def my_inject
    result = []
    self.my_each do |el|
      if result.empty?
        result << el
      else
        result << yield(result.shift, el)
      end
    end
    result[0]
  end

  def my_sort!
    sorted = false

    until sorted
      sorted = true

      (1..self.length).each do |i|
        if yield(self[i - 1], self[i]) == 1
          self[i - 1], self[i] = self[i], self[i - 1]

          sorted = false
        end
      end
    end

    self
  end

  def my_sort
    sorted = false
    result = self.dup
    until sorted
      sorted = true

      (1..result.length).each do |i|
        if yield(result[i - 1], result[i]) == 1
          result[i - 1], result[i] = result[i], result[i - 1]

          sorted = false
        end
      end
    end

    result
  end
end

def eval_block(*args)
  puts 'NO BLOCK GIVEN!' if 
end
