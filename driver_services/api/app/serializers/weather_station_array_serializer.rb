class WeatherStationArraySerializer < ActiveModel::Serializer
  attributes :id, :station_number, :location, :road, :observation_data
  root nil
end
