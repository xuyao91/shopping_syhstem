class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.column :owner_id, :integer
      t.column :file_name, :string
      t.column :file_path, :string
      t.column :type, :string
      t.column :deleted, :boolean, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
