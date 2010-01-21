class UserAssignment < ActiveRecord::Base
  belongs_to :user_role
  belongs_to :user
  
  validates_presence_of :user_role_id
  validates_presence_of :user_id
end
