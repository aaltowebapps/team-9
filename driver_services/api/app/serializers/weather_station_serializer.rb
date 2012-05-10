class WeatherStationSerializer < ActiveModel::Serializer
  attributes :id, :location, :road
  has_one :observation_data
end
