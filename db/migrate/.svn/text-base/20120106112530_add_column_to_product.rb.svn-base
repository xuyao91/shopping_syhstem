class AddColumnToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :quantity, :integer, :default => 100
  end

  def self.down
    remove_column :products, :quantity, :integer, :default => 100
  end
end
