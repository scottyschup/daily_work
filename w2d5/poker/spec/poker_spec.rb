require 'rspec'
require 'poker'

describe Card do

end

describe Hand do
  let(:ace_s)   { instance_double("Card", value: 14, suit: :S) }
  let(:king_s)  { instance_double("Card", value: 13, suit: :S) }
  let(:queen_s) { instance_double("Card", value: 12, suit: :S) }
  let(:jack_s)  { instance_double("Card", value: 11, suit: :S) }
  let(:ten_s)   { instance_double("Card", value: 10, suit: :S) }
  let(:ace_c)   { instance_double("Card", value: 14, suit: :C) }
  let(:king_c)  { instance_double("Card", value: 13, suit: :C) }
  let(:king_h)  { instance_double("Card", value: 13, suit: :H) }
  let(:ace_d)   { instance_double("Card", value: 14, suit: :D) }
  let(:ace_h)   { instance_double("Card", value: 14, suit: :H) }
  let(:nine_h)  { instance_double("Card", value: 9 , suit: :H) }
  let(:nine_s)  { instance_double("Card", value: 9 , suit: :S) }

  subject(:hand4) { Hand.new([ace_s, ace_c, ace_d, ace_h, queen_s]) }
  subject(:hand3) { Hand.new([ace_s, ace_c, ace_d, king_c, queen_s]) }
  subject(:low_hand3) { Hand.new([ace_s, king_h, king_s, king_c, queen_s]) }
  subject(:pair) { Hand.new([ace_s, ace_c, jack_s, king_c, queen_s]) }
  subject(:two_pairs) { Hand.new([ace_s, ace_c, king_s, king_c, queen_s]) }
  subject(:low_two_pairs) { Hand.new([ace_s, ace_c, nine_h, nine_s, queen_s]) }
  subject(:sim_two_pairs) { Hand.new([ace_s, ace_c, king_c, king_s, queen_s]) }
  subject(:straight) { Hand.new([ace_s, ten_s, jack_s, king_c, queen_s]) }
  subject(:diff_straight) { Hand.new([ace_d, ten_s, jack_s, king_c, queen_s]) }
  subject(:low_straight) { Hand.new([nine_h, ten_s, jack_s, king_c, queen_s]) }
  subject(:flush) { Hand.new([ace_s, nine_s, jack_s, king_s, queen_s]) }
  subject(:high) { Hand.new([ace_s, nine_h, jack_s, king_c, queen_s]) }
  subject(:high2) { Hand.new([ace_d, nine_h, jack_s, king_c, queen_s]) }

  describe '#compare' do
    it 'compares straight and pair' do
      expect(straight.compare(pair)).to eq(straight)
    end

    it 'compares pair and straight' do
      expect(pair.compare(straight)).to eq(straight)
    end

    it 'compares the same hand' do
      expect(high.compare(high2)).to eq([high, high2])
    end

    it 'compares straights with different values' do
      expect(straight.compare(low_straight)).to eq(straight)
    end

    it 'compares straights with similar values' do
      expect(straight.compare(diff_straight)).to eq([straight, diff_straight])
    end

    it 'compares sets with different values' do
      expect(hand3.compare(low_hand3)).to eq(hand3)
    end

    it 'compares two pairs with different values' do
      expect(two_pairs.compare(low_two_pairs)).to eq(two_pairs)
    end

    it 'compares two pairs with similar values' do
      expect(two_pairs.compare(sim_two_pairs)).to eq([two_pairs, sim_two_pairs])
    end


  end

  describe 'four?' do
    it('detects four of a kind') { expect(hand4).to be_four }
    it ('no false positive') { expect(high.four?).to eq(false) }
  end

  describe 'flush?' do
    it('detects flush') { expect(flush).to be_flush }
    it('no false positive') { expect(high.flush?).to eq(false) }
  end

  describe 'straight?' do
    it('detects straight') { expect(straight).to be_straight }
    it('no false positive') { expect(high.straight?).to eq(false) }
  end

  describe 'three?' do
    it('detects three of a kind') { expect(hand3).to be_three }
    it('no false positive') { expect(high.three?).to eq(false) }
  end

  describe 'two_pairs?' do
    it('detects two pairs') { expect(two_pairs).to be_two_pairs }
    it('no false positive') { expect(high.two_pairs?).to eq(false) }
  end

  describe 'pair?' do
    it('detects pair') { expect(pair).to be_pair }
    it('no false positive') { expect(high.pair?).to eq(false) }
  end

end

describe Player do
  let(:ace_s)   { instance_double("Card", value: 14, suit: :S) }
  let(:king_s)  { instance_double("Card", value: 13, suit: :S) }
  let(:queen_s) { instance_double("Card", value: 12, suit: :S) }
  let(:jack_s)  { instance_double("Card", value: 11, suit: :S) }
  let(:ten_s)   { instance_double("Card", value: 10, suit: :S) }
  let(:straight_flush)   { Hand.new([ace_s, king_s, queen_s, jack_s, ten_s]) }
  subject(:player)       { Player.new(1000, straight_flush) }
  let(:game)             { Game.new([player], Deck.new) }

  describe '#discard' do
    it 'removes selected cards from hand' do
      game
      player.discard(ace_s)
      expect(player.card_count).to eq(4)
    end
  end

  describe '#make_bet' do
    it 'removes money from bankroll' do
      player.make_bet(100)
      expect(player.bankroll).to eq(900)
    end
  end

  describe '#fold' do
    it 'returns hand to deck' do
      game
      player.fold
      expect(player.card_count).to eq(0)
    end
  end
end

describe Deck do
  describe '#shuffle'

end

describe Game do

end
