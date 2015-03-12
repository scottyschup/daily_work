require_relative 'card'

# Hand class for Poker
class Hand
  RANKING = [
    :straight_flush?,
    :four?,
    :full_house?,
    :flush?,
    :straight?,
    :three?,
    :two_pairs?,
    :pair?
  ]

  ORDINALS = [
    :straight_flush?,
    :flush?,
    :straight?,
    :high_card
  ]

  GROUPS = [
    :four?,
    :three?,
    :full_house?,
    :pair?
  ]

  attr_accessor :cards

  def self.hand_hash(hand)
    this = Hash.new { |h, k| h[k] = 0 }

    hand.cards.each do |card|
      this[card.value] += 1
    end

    this
  end

  def initialize(cards_arr)
    @cards = cards_arr
  end

  def compare(other_hand)
    RANKING.each do |type|
      winner = []
      this, other = send(type), other_hand.send(type)

      winner << self if this
      winner << other_hand if other

      return winner[0] if winner.length == 1
      return tie_breaker(other_hand, type) if winner.length == 2
    end

    tie_breaker(other_hand, :high_card)
  end

  def tie_breaker(hand, type)
    if ORDINALS.include?(type)
      ordinal_tie(hand)
    elsif GROUPS.include?(type)
      grouping_tie(hand)
    else
      # handles two pairs
    end
  end

  def ordinal_tie(other_hand)
    self_values, other_values = [self, other_hand].map do |hnd|
      hnd.cards.map(&:value).sort.reverse
    end

    5.times do |i|
      if other_values[i] > self_values[i]
        return other_hand
      elsif other_values[i] < self_values[i]
        return self
      end
    end
    return [self, other_hand]
  end

  def grouping_tie(hand)
    self_hash, other_hash = [self, hand].map do |hnd|
      Hand.hand_hash(hnd)
    end

    self_value, other_value = [self_hash, other_hash].map do |hsh|
      hsh.to_a.sort_by { |arr| arr[1] }.last[0]
    end

    if other_value > self_value
      return hand
    elsif other_value < self_value
      return self
    else
      # high card on cards whose count == 1
    end
  end

  def straight_flush?
    straight? && flush?
  end

  def four?
    same(4)
  end

  def full_house?
    same(3) && same(2)
  end

  def flush?
    cards.map(&:suit).all? { |suit| suit == cards[0].suit }
  end

  def straight?
    card_values = cards.map(&:value).sort
    return true if card_values == [14, 5, 4, 3, 2]

    4.times do |i|
      return false unless card_values[i] + 1 == card_values[i + 1]
    end

    true
  end

  def three?
    same(3)
  end

  def two_pairs?
    check = Hand.hand_hash(self)
    check.values.select { |val| val == 2 }.count == 2
  end

  def pair?
    same(2)
  end

  def same(num)
    check = Hand.hand_hash(self)
    check.values.include?(num)
  end
end
