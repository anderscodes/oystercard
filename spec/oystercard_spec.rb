require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }

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

  describe '#touch_in' do
    context 'when there are sufficient funds' do
      before do
        oystercard.top_up(10)
        oystercard.touch_in(station)
      end
      it 'should set in_journey to true if touched in' do
        expect(oystercard.in_journey?).to eq true
      end
      it 'saves an entry station' do
        expect(oystercard.entry_station).to eq station
      end
    end
    it 'raises an error if the card has insufficient balance to touch in' do
      expect { oystercard.touch_in(station) }.to raise_error "Insufficient balance"
    end
  end


  describe '#touch_out' do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
    end
    it 'should set in_journey to false' do
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
    it 'should deduct the minimum fare from the balance' do
      expect {oystercard.touch_out}.to change {oystercard.balance}.by(-Oystercard::MIN_BALANCE)
    end
  end


end
