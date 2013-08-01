class AddUnitPriceToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders,:total_price,:string
  end

  def self.down
    remove_column :orders,:total_price
  end
end
