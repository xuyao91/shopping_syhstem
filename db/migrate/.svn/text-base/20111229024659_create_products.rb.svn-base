class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :genre_id, :integer
      t.column :name, :string
      t.column :describe, :text
      t.column :price, :string
      t.column :deleted, :boolean, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
