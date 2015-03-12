class Fixnum
  def in_words
    digits = {}
    text = []

    return "zero" if self == 0

    digits["trillion"] = self % 1_000_000_000_000_000 / 1_000_000_000_000
    digits["billion"] = self % 1_000_000_000_000 / 1_000_000_000
    digits["million"] = self % 1_000_000_000 / 1_000_000
    digits["thousand"] = self % 1_000_000 / 1000
    digits["hundred"] = self % 1000

    digits.each do |key, value|
      if value > 0 && key != "hundred"
        text << "#{convert(value)} #{digits.key(value)}"
      elsif value > 0
        text << "#{convert(value)}"
      end
    end

    text.join(" ")
  end

  def convert(num)
    numbers = {
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9,
      ten: 10,
      eleven: 11,
      twelve: 12,
      thirteen: 13,
      fourteen: 14,
      fifteen: 15,
      sixteen: 16,
      seventeen: 17,
      eighteen: 18,
      nineteen: 19,
      twenty: 20,
      thirty: 30,
      forty: 40,
      fifty: 50,
      sixty: 60,
      seventy: 70,
      eighty: 80,
      ninety: 90
    }
    text = []

    if num >= 100
      text << "#{numbers.key(num / 100)} hundred"
      num %= 100
    end

    if num >= 20
      text << "#{numbers.key(num - (num % 10))}"
      num %= 10
    end

    if num < 20 && num >= 1
      text << "#{numbers.key(num)}"
    end

    text.join(" ")
  end
end
