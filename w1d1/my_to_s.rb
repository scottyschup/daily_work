def num_to_s(num, base)
  power = 0
  digits = []

  while base ** power < num
    digits << (num / (base ** power)) % base
    power += 1
  end

  convert(digits).reverse
end

def convert(digits)
  result = ""
  hash = {
    0 => '0',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F'
  }

  digits.each do |digit|
    result += hash[digit]
  end

  result
end

p num_to_s(234, 2)
