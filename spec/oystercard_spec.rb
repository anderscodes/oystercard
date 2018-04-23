require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#initialize' do
    it 'should have a default balance equal to DEFAULT_BALANCE' do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end
end

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
    it 'should raise an error if the balance is at max limit' do
      allow(oystercard).to receive(:limit_reached?) { true }
      expect { oystercard.top_up(10) }.to raise_error "This card has reached its limit of #{Oystercard::MAX_BALANCE}"
    end
  end

end
