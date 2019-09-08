class AddIndexes < ActiveRecord::Migration
  def change
    add_index :favorites, :user_id
    add_index :favorites, :station_id

    add_index :observations, :station_id

    add_index :reading_types, :metric_id

    add_index :readings, :observation_id
    add_index :readings, :reading_type_id

    add_index :stations, :state_id
    add_index :stations, :timezone_id

    add_index :users, :timezone_id
  end
end
