class WeatherStationArraySerializer < ActiveModel::Serializer
  attributes :id, :station_number, :location, :road
  has_one :observation_data, :serializer => ObservationDataSerializer
  root nil
end
