class ChangeUserSaltToText < ActiveRecord::Migration
  def change
    change_column :users, :salt, :text, :null => false
  end
end
