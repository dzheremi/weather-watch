class AddCapitalToStations < ActiveRecord::Migration
  def change
    add_column :stations, :capital, :boolean, :after => :state_id, :default => false
  end
end
