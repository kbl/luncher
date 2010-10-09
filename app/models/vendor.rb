class Vendor < ActiveRecord::Base

  has_many :lunches, :dependent => :destroy
  has_many :orders, :through => :lunches
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :available
  
  named_scope :all_available, :conditions => {:available => true}
  
  def to_s
    name
  end

  def notifiable_users
    orders.ordered_today.map(&:user).uniq.select { |user| user.email_notification_enabled? }
  end
  
  def has_incomplete_orders?
    !orders.incomplete.empty?
  end

  def notification_sent_today?
    notification_sent_on == Date.current
  end

  def removable?
    lunches.all?(&:removable?)
  end
  
  def hide
    lunches.each do |lunch|
      lunch.destroy if lunch.removable?
    end
    update_attribute(:available, false)
  end
  
end

# == Schema Information
#
# Table name: vendors
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  notification_sent_on :date
#  available            :boolean         default(TRUE)
#

