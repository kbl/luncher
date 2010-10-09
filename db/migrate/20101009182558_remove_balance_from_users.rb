class RemoveBalanceFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :balance
  end

  def self.down
    add_column :users, :balance, :float
  end
end
