class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.timestamps
      t.string :login, :null => false
      t.string :email, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.float :balance, :default => 0
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.string :perishable_token, :null => false
      t.integer :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
    end
    
    add_index :users, :login
    add_index :users, :perishable_token

    usr = User.create \
              :login => 'root',
              :email => 'lunch_admin@ayoy.net',
              :first_name => 'root',
              :last_name => 'root',
              :password => 'rootme',
              :password_confirmation => 'rootme'
  end

  def self.down
    drop_table :users
  end
end