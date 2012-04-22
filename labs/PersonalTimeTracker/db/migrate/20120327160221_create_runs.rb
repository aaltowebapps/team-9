class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :task_id
      t.datetime :completed_at

      t.timestamps
    end
  end
end
