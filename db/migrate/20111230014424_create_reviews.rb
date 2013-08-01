class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.column :user_id, :integer
      t.column :product_id, :integer
      t.column :content,:text
      t.column :deleted, :boolean, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
