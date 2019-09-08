class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|

      t.string :name, null: false
      t.string :abbreviation, null: false

      t.timestamps
    end
  end
end
