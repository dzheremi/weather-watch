class AddIndexToNumericDataValuesInReadings < ActiveRecord::Migration
  def change
    add_index :readings, :numeric_value
  end
end
