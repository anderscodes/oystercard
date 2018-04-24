require 'station.rb'

describe Station do

  subject(:station) { described_class.new(name, zone) }
  let(:name) { 'London Bridge' }
  let(:zone) { 1 }

  describe '#initialize' do
    it 'sets name to name' do
      expect(station.name).to eq name
    end
    it 'sets zone to zone' do
      expect(station.zone).to eq zone
    end
  end
end
