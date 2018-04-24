require 'csv'

class Station

attr_reader :name, :zone

  def initialize(name, station_path = './resources/stations.csv')
    @name = name
    @station_path = station_path
    @zone = get_zone(name)
  end

  def get_zone(name)
    CSV.foreach(@station_path) do |line|
      station, zone = line
      return zone.to_i if station == name
    end
    raise "Station not recognized"
  end

end
