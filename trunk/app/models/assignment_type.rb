class AssignmentType < ActiveRecord::Base
  has_many :project_assignments, :dependent => :destroy
end
