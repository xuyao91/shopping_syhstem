class CreateSubGenres < ActiveRecord::Migration
  def self.up
    create_table :sub_genres do |t|
      t.column :sub_name, :string
      t.column :genre_id, :integer
      t.column :deleted, :boolean, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_genres
  end
end
