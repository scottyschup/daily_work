def median(arr)
  if arr.length.even?
    (arr[arr.length / 2] + arr[(arr.length / 2) - 1]) / 2.0
  else
    arr[arr.length / 2]
  end
end

p median([1,2,5,6])
