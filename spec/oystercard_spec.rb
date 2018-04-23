require './lib/oystercard.rb'

describe Oystercard do

  describe '#balance' do
    it 'a should have a balance of 0' do
      expect(subject.balance).to eq 0      
    end
  end
end
