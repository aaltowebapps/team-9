class ChangeRoadTypeInWeatherStations < ActiveRecord::Migration
  def change
    change_column(:weather_stations, :road, :integer)
  end
end
