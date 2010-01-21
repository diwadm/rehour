# default project assignment types
['Date Type' => 'Date', 'Time Allotted - Fixed' => 'Fixed', 'Time Allotted - Flexible' => 'Flex'].each { |name, code| AssignmentType.create(:name => name, :short_code => code) }

# default user roles
['Admin', 'Consultant', 'Project Manager', 'Report User'].each { |r| UserRole.create(:name => r) }

Department.create(:name => 'Administration', :code => 'ADM')

# default admin user
user = User.new({:login => 'admin', :password => 'admin1', :password_confirmation => 'admin1', :email => 'diwadm@gmail.com', :name => 'Admin', :department_id => 1, :last_name => 'User'})
user.save

UserAssignment.new({:user_role_id => 1, :user_id => 1}).save
