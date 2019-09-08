class CreateReadingTypes < ActiveRecord::Migration
  def change
    create_table :reading_types do |t|

      t.string :name, null: false
      t.string :bom_field_name, null: false
      t.boolean :numeric, default: true
      t.integer :metric_id

      t.timestamps
    end
  end
end
