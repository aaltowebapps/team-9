class WeatherStation < ActiveRecord::Base
  has_one :observation_data
end
