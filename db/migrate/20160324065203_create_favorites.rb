class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|

      t.integer :user_id, null: false
      t.integer :station_id, null: false

      t.timestamps
    end
  end
end
