class AddSaltToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salt, :string, :null => false, :after => :password
  end
end
