root_user = User.create \
          :login => 'mapi',
          :email => 'm.pietraszek@gmail.com',
          :first_name => 'Marcin',
          :last_name => 'Pietraszek',
          :password => 'mapi',
          :password_confirmation => 'rootme'

# This will create the 'Administrator' user group and 
# associate it to the user.
Lockdown::System.make_user_administrator(User.find(root_user.id)) unless root_user.id.nil?

UserGroup.create :name => 'Usersadmin'
UserGroup.create :name => 'Users'

Setting.instance.update_attributes \
          :system_locked => false,
          :automatic_locking => false,
          :automatic_locking_time => Time.parse('10:00')
