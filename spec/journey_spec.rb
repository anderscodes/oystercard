require 'journey.rb'

describe Journey do

  subject(:journey) { described_class.new(station) }
  let(:station) { double(:station) }

  describe '#initialize' do
    it 'sets entry station on initialize' do
      expect(journey.entry_station).to eq station
    end
  end

  describe '#finish_journey' do
    it 'sets an exit station' do
      journey.finish_journey(station)
      expect(journey.exit_station).to eq station
    end
  end

  describe '#fare' do
    context 'if the journey has been finished' do
      before { journey.finish_journey(station) }
      it 'returns the fare' do
        expect(journey.fare).to eq Journey::MIN_FARE
      end
    end
    context 'if the journey has not been finished' do
      it 'returns the penalty fare' do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end

end
