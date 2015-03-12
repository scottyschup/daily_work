def stock_picker(arr)
  indices = []
  diff = 0

  (0...(arr.length - 1)).each do |start|
    ((start + 1)...(arr.length)).each do |finish|
      if (arr[finish] - arr[start]) > diff
        indices[0] = [start, finish]
        diff = arr[finish] - arr[start]
      end
    end
  end

  indices
end

p stock_picker([3, 4, 7, 8, 1, 1, 2])
