require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }



  describe '#initialize' do
    it 'should have a default balance equal to DEFAULT_BALANCE' do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end
  it 'should not be in journey as a default' do
    expect(oystercard.in_journey?).to eq false
  end
end

  describe '#balance' do
    it 'a should have a balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should allow user to increase balance of the oystercard' do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end
    it 'should raise an error if the balance is at max limit' do
      allow(oystercard).to receive(:balance) { 60 }
      expect { oystercard.top_up(40) }.to raise_error "Invalid top up. This card has a max limit of #{Oystercard::MAX_BALANCE}"
    end
  end

  # it { is_expected.to respond_to(:touch_out) }

  describe '#deduct' do
    it 'should reduce the balance of the card by the given amount' do
      oystercard.top_up(20)
      oystercard.deduct(10)
      expect(oystercard.balance).to eq 20 - 10
    end
  end

  describe 'Methods that test a in journey card' do
    describe '#touch_in' do
      it 'should set in_journey to true if touched in' do
        oystercard.touch_in
        expect(oystercard.in_journey?).to eq true
      end
    end
    it 'raises an error if the card has insufficient balance to touch in' do
      expect { oystercard.touch_in }.to raise_error "Insufficient balance"
    end
  end

  describe 'Methods that test a in journey card' do
    before do
      allow(oystercard.balance).to receive(:top_up) {10}
      oystercard.touch_in
    end
    describe '#touch_out' do
      it 'should set in_journey to false' do
        allow(oystercard).to receive(:top_up) {10}
        expect(oystercard.in_journey?).to eq false
      end
    end
  end

end
