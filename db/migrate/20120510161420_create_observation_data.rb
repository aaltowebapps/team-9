class CreateObservationData < ActiveRecord::Migration
  def change
    create_table :observation_data do |t|
      t.integer :temperature
      t.integer :visibility
      t.integer :weather_station_id

      t.timestamps
    end
  end
end
