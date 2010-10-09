class Order < ActiveRecord::Base
  belongs_to :lunch # foreign key - lunch_id
  belongs_to :user # foreign key - user_id
  
  validates_presence_of :lunch_id
  validates_presence_of :user_id

  named_scope :by_user, lambda { |user| {:conditions => {:user_id => user.id} } }
  named_scope :ordered_by_vendor_name, :order => "vendors.name ASC", :include => {:lunch => :vendor}
  named_scope :ordered_by_lunch_name, :order => "lunches.name ASC", :include => :lunch
  named_scope :incomplete, :conditions => {:complete => false}
  


  def status
    return "new order" unless complete
    "order complete"
  end
  
  def mark_as_complete
    update_attribute(:complete, true)
  end

  def mark_as_new
    update_attribute(:complete, false)
  end

  protected

  def validate
    errors.add_to_base("System is locked, can't process order") if Setting.instance.system_locked
  end
  
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  lunch_id   :integer
#  user_id    :integer
#  total      :float           default(0.0)
#  created_at :datetime
#  updated_at :datetime
#  complete   :boolean         default(FALSE)
#

