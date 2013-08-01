class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :product_id, :integer
      t.column :user_id,  :integer
      t.column :count,:integer,:default => 1
      t.column :user_address_id, :integer
      t.column :deleted, :boolean, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
