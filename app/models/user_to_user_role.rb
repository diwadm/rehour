class UserToUserRole < ActiveRecord::Base
  set_table_name 'USER_TO_USERROLE'
  belongs_to :user, :primary_key => 'USER_ID'
  
  named_scope :consultants, :conditions => {:ROLE => 'ROLE_CONSULTANT'}
  
  def self.destroy(role, user_id)
    self.delete_all("ROLE = #{role} AND USER_ID = #{user_id}")
  end
  
  def self.destroy_all_for_user(user_id)
    self.delete_all("USER_ID = #{user_id}")
  end
  
  def self.role_exists_for_user?(role, user_id)
    self.find_by_USER_ID_and_ROLE(user_id, role)
  end
end
