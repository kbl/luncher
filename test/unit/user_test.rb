require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should assign default balance when user created without balance" do
    user = Factory(:user)
    assert_equal user.balance, 0, "Default balance is incorrect"
  end

  test "should return full name as last name and first name" do
    user = Factory(:user, :first_name => "Johson", :last_name => "Ben")
    assert_equal "Ben Johson", user.full_name 
                 "Full name is different than last_name-space-first_name"
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
#  balance                    :float           default(0.0)
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

