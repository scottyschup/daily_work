class Fixnum
  def factors
    result = []
    1.upto(Math.sqrt(self)).select {|x| self % x == 0}.each do |i|
      result << i
      result << self / i
    end
    result.sort
  end
end

def bubble_sort(arr)
  sorted = false
  until sorted
    swapped = false
    (0...arr.length - 1).each do |index|
      if arr[index] > arr[index + 1]
        arr[index], arr[index +1] = arr[index + 1],arr[index]
        swapped = true
      end
      sorted = true unless swapped
    end
  end
  arr
end

def substrings(str)
  dictionary = create_dictionary
  array = []
  (0...str.length).each do |i|
    (i...str.length).each do |j|
      array << str[i..j] if check(str[i..j], dictionary)
    end
  end
  array
end

def check(word, dictionary)
  dictionary.has_key?(word)
end

def create_dictionary
  dictionary = {}
  File.readlines("dictionary.txt").each do |line|
    dictionary[line.chomp] = true
  end
  dictionary
end
