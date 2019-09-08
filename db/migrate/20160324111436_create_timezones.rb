class CreateTimezones < ActiveRecord::Migration
  def change
    create_table :timezones do |t|

      t.string :name, null: false
      t.string :abbreviation, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
