class WeatherStationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :road
  has_one :observation_data
  root nil
end
