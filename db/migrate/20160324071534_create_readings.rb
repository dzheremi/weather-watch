class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|

      t.integer :observation_id, null: false, index: true
      t.integer :reading_type_id, null: false
      t.decimal :numeric_value, :precision => 10, :scale => 3, :default => 0.00
      t.string :string_value

      t.timestamps
    end
  end
end
