class CreateWeatherStations < ActiveRecord::Migration
  def change
    create_table :weather_stations do |t|
      t.string :location
      t.string :road

      t.timestamps
    end
  end
end
