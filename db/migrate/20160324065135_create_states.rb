class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|

      t.string :name, null: false
      t.string :abbreviation, null: false
      t.string :product_group, null: false

      t.timestamps
    end
  end
end
