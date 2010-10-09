class Lunch < ActiveRecord::Base

  belongs_to :vendor
  has_many :orders, :dependent => :destroy
  has_many :users, :through => :orders, :dependent => :destroy

  validates_presence_of :vendor_id
  validates_presence_of :name
  validates_presence_of :description

  named_scope :ordered_by_name, :order => "name ASC"
  
  after_destroy :release_vendor



  def has_pending_orders?
    orders.any? {|order| order.complete == false}
  end

  def removable?
    orders.empty? or orders.all? {|order| order.complete == false}
  end

  def discount_price
    price * 0.9
  end
  
  private

  def release_vendor
    if vendor.lunches.empty? and !vendor.available
      vendor.destroy
    end
  end
end

# == Schema Information
#
# Table name: lunches
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  price       :float           default(10.0)
#  created_at  :datetime
#  updated_at  :datetime
#  vendor_id   :integer
#  available   :boolean         default(TRUE)
#

