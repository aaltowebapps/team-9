class CreateWeatherStations < ActiveRecord::Migration
  def change
    create_table :weather_stations do |t|
      t.string :location
      t.integer :temperature
      t.integer :visibility

      t.timestamps
    end
  end
end
