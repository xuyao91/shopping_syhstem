class CreateProCollects < ActiveRecord::Migration
  def self.up
    create_table :pro_collects do |t|
      t.column :user_id, :integer
      t.column :product_id, :integer
      t.column :deleted, :boolean, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pro_collects
  end
end
