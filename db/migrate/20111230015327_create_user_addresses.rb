class CreateUserAddresses < ActiveRecord::Migration
  def self.up
    create_table :user_addresses do |t|
      t.column :user_id, :integer
      t.column :name, :string
      t.column :address, :string
      t.column :code, :string
      t.column :tel, :string
      t.column :deleted, :boolean, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_addresses
  end
end
