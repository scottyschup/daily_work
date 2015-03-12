require 'rspec'
require 'array_ex'

describe "#my_uniq" do
  let(:small_array) {[1,2,1,3,3]}
  it "removes duplicates from non-empty array" do
    expect(small_array.my_uniq).to eq([1,2,3])
  end

  it "returns empty array when given empty array" do
    expect([].my_uniq).to eq([])
  end
end

describe "#two_sum" do
  it "returns pairs of indexes of elts that sum to zero" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it "returns empty array for empty array" do
    expect([].two_sum).to eq([])
  end
end

describe "my_transpose" do
  let(:matrix) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ] }

  it "transposes a square array" do
    expect(my_transpose(matrix)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end
end

describe "stock_picker" do
  let(:predictable) { [1, 2, 4, 7] } # => [0, 3]
  let(:unpredictable) { [8, 5, 2, 3, 5, 7, 9, 8, 6, 1, 5] } # => [2, 6]

  context "picks best pair" do
    it "returns first and last for sorted input" do
      expect(stock_picker(predictable)).to eq([0, 3])
    end
    it "returns best pair for 'real' input" do
      expect(stock_picker(unpredictable)).to eq([2, 6])
    end
  end
end
