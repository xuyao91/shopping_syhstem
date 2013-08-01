class AddColumn < ActiveRecord::Migration
  def self.up
    add_column(:products, :sub_genre_id, :integer)
  end

  def self.down
    remove_column(:products, :sub_genre_id, :integer)
  end
end
