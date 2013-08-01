class CreateAdmins < ActiveRecord::Migration
  
  def self.up
    create_table "admins", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :deleted, :boolean, :default => false, :null => false
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end    

  end

  def self.down
    drop_table "admins"
  end
end
