require './lib/oystercard.rb'

describe Oystercard do

subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'a should have a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

describe '#top_up' do
  it 'should allow user to increase balance of the oystercard' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
  end
end

end
