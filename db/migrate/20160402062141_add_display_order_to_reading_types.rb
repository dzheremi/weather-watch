class AddDisplayOrderToReadingTypes < ActiveRecord::Migration
  def change
    add_column :reading_types, :display_order, :integer, :after => :id, default: 0
  end
end
