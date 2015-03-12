def caesar(string, offset)
  letters = string.split("")
  result = []

  letters.each do |letter|
    num = letter.ord + offset
    num -= 26 if num > 122
    result << num.chr
  end

  result.join("")
end

# p caesar("pez", 2)
