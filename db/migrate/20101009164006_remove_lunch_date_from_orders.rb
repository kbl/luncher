class RemoveLunchDateFromOrders < ActiveRecord::Migration
  def self.up
    remove_column :orders, :lunch_date
  end

  def self.down
    add_column :orders, :lunch_date, :date
  end
end
