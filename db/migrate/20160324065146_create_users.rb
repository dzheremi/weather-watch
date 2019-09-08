class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :username, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.text :password, null: false
      t.integer :timezone_id, null: false

      t.timestamps
    end
  end
end
