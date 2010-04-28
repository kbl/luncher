class AddLunchDateToOrders < ActiveRecord::Migration
  
  def self.up
    add_column :orders, :lunch_date, :date
    Order.all.each do |o|
      o.lunch_date = o.lunch.date || Date.current
      o.save
    end
  end

  def self.down
    remove_column :orders, :lunch_date
  end

end
