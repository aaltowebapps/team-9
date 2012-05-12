class WeatherStationArraySerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :road
  root nil
end
