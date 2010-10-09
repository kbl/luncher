class RemoveDateFromLunches < ActiveRecord::Migration
  def self.up
    remove_column :lunches, :date
  end

  def self.down
    add_column :lunches, :date, :date
  end
end
