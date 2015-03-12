def my_transpose(arr)
  result = []
  num_rows = arr.length
  num_rows.times { result << [] }
  arr.each_with_index do |row, i|
    row.each_with_index do |element, j|
      result[j][i] = element
    end
  end
  result
end

# p my_transpose([
#   [0, 1, 2],
#   [3, 4, 5],
#   [6, 7, 8]
#   ])
