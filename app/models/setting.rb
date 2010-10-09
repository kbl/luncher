class Setting < ActiveRecord::Base
  after_save :restart_scheduler
  acts_as_singleton

  def self.automatic_locking_time_to_cron
    "#{Setting.instance.automatic_locking_time.min} #{Setting.instance.automatic_locking_time.hour} * * *"
  end

  def self.toggle_system_locked(value)
    Setting.instance.update_attribute(:system_locked, value)
  end

  private
  def restart_scheduler
    # TODO: make it working
    # puts "Restarted scheduler daemon"
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

