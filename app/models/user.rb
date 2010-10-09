class User < ActiveRecord::Base

  has_and_belongs_to_many :user_groups
  has_many :orders
  has_many :lunches, :through => :orders
  
  acts_as_authentic

  validates_presence_of :login
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  named_scope :ordered_by_login, :order => "login ASC"
  named_scope :ordered_by_last_name,
              :order => "last_name ASC"

  def editor_ids
    ug = UserGroup.find_by_name(UserGroup::ADMINS)
    # Return the user_ids associated to the user group plus this user's id
    ug.user_ids | [self.id]
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def full_name
    [last_name, first_name].join(' ')
  end

  def is_admin?
    user_groups.map { |g| g.name }.include?(UserGroup::ADMINS)
  end

end


# == Schema Information
#
# Table name: users
#
#  id                         :integer         not null, primary key
#  created_at                 :datetime
#  updated_at                 :datetime
#  login                      :string(255)     not null
#  email                      :string(255)     not null
#  first_name                 :string(255)     not null
#  last_name                  :string(255)     not null
#  crypted_password           :string(255)     not null
#  password_salt              :string(255)     not null
#  persistence_token          :string(255)     not null
#  perishable_token           :string(255)     not null
#  login_count                :integer         default(0), not null
#  last_request_at            :datetime
#  last_login_at              :datetime
#  current_login_at           :datetime
#  last_login_ip              :string(255)
#  current_login_ip           :string(255)
#  email_notification_enabled :boolean         default(TRUE)
#

