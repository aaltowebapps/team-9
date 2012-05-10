class WeatherStationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :road, :created_at, :updated_at
  has_one :observation_data
end
