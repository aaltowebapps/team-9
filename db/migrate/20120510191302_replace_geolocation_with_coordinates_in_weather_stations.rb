class ReplaceGeolocationWithCoordinatesInWeatherStations < ActiveRecord::Migration
  def up
    remove_column :weather_stations, :location
    add_column :weather_stations, :latitude, :float
    add_column :weather_stations, :longitude, :float
  end

  def down
    add_column :weather_stations, :location, :string
    remove_column :weather_stations, :latitude
    remove_column :weather_stations, :longitude
  end
end
  