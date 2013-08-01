class AddColumnToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders,:flag, :boolean,:default =>false, :null =>false 
  end

  def self.down
    remove_column :orders,:flag, :boolean,:default =>false, :null =>false 
  end
end
