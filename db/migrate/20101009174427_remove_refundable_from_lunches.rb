class RemoveRefundableFromLunches < ActiveRecord::Migration
  def self.up
    remove_column :lunches, :refundable
  end

  def self.down
    add_column :lunches, :refundable, :boolean
  end
end
