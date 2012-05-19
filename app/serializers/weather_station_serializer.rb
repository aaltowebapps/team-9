class WeatherStationSerializer < ActiveModel::Serializer
  attributes :id, :road, :locations
  has_one :observation_data
  root nil
end
