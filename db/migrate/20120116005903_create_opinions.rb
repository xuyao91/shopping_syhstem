class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.column :review_id, :integer
      t.column :user_id, :integer
      t.column :opinion, :boolean,:default =>false,:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
