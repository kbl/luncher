require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: settings
#
#  id                       :integer         not null, primary key
#  system_locked            :boolean
#  automatic_locking        :boolean
#  automatic_locking_time   :time
#  lunch_refunding          :boolean
#  refunded_lunches_per_day :integer
#  money_refunded_per_lunch :float
#  created_at               :datetime
#  updated_at               :datetime
#

