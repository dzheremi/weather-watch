class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|

      t.integer :state_id, null: false
      t.string :name, null: false
      t.decimal :latitude, :precision => 5, :scale => 2, :default => 0.00
      t.decimal :longitude, :precision => 5, :scale => 2, :default => 0.00
      t.integer :timezone_id, null: false
      t.string :station_url, null: false
      t.string :json_url, null: false

      t.timestamps
    end
  end
end
