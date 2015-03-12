class Array
  def my_each(&block)
    self.map do |element|
      block.call(element)
    end
    self
  end
end

return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

p return_value
