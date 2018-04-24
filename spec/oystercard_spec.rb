require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }
  let(:max_balance) { described_class::MAX_BALANCE }
  let(:min_balance) { described_class::MIN_BALANCE }

  describe '#initialize' do
    it 'should have a default balance equal to DEFAULT_BALANCE' do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end
    it 'should not be in journey as a default' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#top_up' do
    it 'should allow user to increase balance of the oystercard' do
      top_up_amount = 10
      oystercard.top_up(top_up_amount)
      expect(oystercard.balance).to eq top_up_amount
    end
    it 'should raise an error if the balance is at max limit' do
      expect { oystercard.top_up(max_balance + 1) }.to raise_error "Invalid top up. This card has a max limit of #{max_balance}"
    end

    it 'raises an error when a negative amount is used' do
      expect { oystercard.top_up(-20) }.to raise_error('Amount must be positive')
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
      oystercard.touch_out(station)
      expect(oystercard.in_journey?).to eq false
    end
    it 'should deduct the minimum fare from the balance' do
      expect {oystercard.touch_out(station)}.to change {oystercard.balance}.by(-Oystercard::MIN_BALANCE)
    end

    it 'should save current_journey' do
      oystercard.touch_out(station)
      last_journey = oystercard.journeys.pop
      expect(last_journey[:entry_station]).to eq station
      expect(last_journey[:exit_station]).to eq station
    end

    it 'should reset current_journey' do
      oystercard.touch_out(station)
      expect(oystercard.instance_variable_get(:@current_journey)).to be_an_instance_of(Hash).and be_empty
    end
  end


end
