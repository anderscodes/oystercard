require 'station.rb'
require 'csv'

describe Station do
  before do
    stations_filename = './resources/stations.csv'
    @stations = CSV.read(stations_filename)
  end
  let(:name) { @stations[0][0] }
  let(:zone) { @stations[0][1].to_i }
  subject(:station) { described_class.new(name) }
  let(:bad_name) { 'Swindon' }

  describe '#initialize' do
    it 'sets name to name' do
      expect(station.name).to eq name
    end
    it 'sets zone automatically' do
      expect(station.zone).to eq zone
    end

    context 'when the name is not valid' do
      it 'raises an error' do
        expect { Station.new(bad_name) }.to raise_error("Station not recognized")
      end
    end
  end
end
