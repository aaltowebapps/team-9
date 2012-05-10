class WeatherStation < ActiveRecord::Base
  has_one :observation_data
  validates_presence_of :latitude, :longitude
end
