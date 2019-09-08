class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|

      t.integer :station_id, null: false, index: true
      t.timestamp :recording_time

      t.timestamps
    end
  end
end
