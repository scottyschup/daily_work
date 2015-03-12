require 'rspec'
require 'hanoi'

describe TowersOfHanoiGame do
  subject(:game) { TowersOfHanoiGame.new }
  describe "#move" do
    context "invalid move" do
      it "returns error" do
        game.move(0, 1)
        expect { game.move(0, 1) }.to raise_error
      end
    end

    context "valid move" do
      it "takes from top of source stack and places on top of goal stack" do
        game.move(0, 1)
        expect(game.stacks).to eq([[3, 2], [1], []])
      end
    end
  end

  describe "#won?" do
    context "gome won" do
      it "returns true" do
        game.stacks = [[], [3, 2, 1], []]
        expect(game).to be_won
      end
    end

    context "game not won yet" do
      it "returns false" do
        expect(game).not_to be_won
      end
    end
  end

  describe "#render" do
    it "converts stacks to printable string" do
      expect(game.render).to eq("3 2 1\n\n")
    end
  end
end
