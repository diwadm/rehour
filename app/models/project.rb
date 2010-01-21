class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :project_assignments, :dependent => :destroy
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_presence_of :project_code
  
  validates_length_of :name, :in => 3..255
  validates_length_of :project_code, :in => 3..32
  
  default_scope :order => 'is_default DESC, name ASC'
  
  named_scope :active, :conditions => {:is_active => true}, :order => 'name'
  named_scope :inactive, :conditions => {:is_active => false}, :order => 'name'
  
  named_scope :default, :conditions => {:is_default => true}, :order => 'name'
  named_scope :not_default, :conditions => {:is_default => false}, :order => 'name'
  
  after_save :set_assignments_for_default_project
  def set_assignments_for_default_project
    if is_default?
      for user in User.find(:all)
        # todo, add ASSIGNMENT_TYPE_ID for TIME_ALLOTTED_FLEX in config file
        unless project_assignment = ProjectAssignment.find_by_project_id_and_user_id(self.id, user.id)
          ProjectAssignment.new(:project_id => self.id, :user_id => user.id, :assignment_type_id => 3, :role => 'Default').save
        end
        
      end
    end
  end
  
  def active
    self.is_active ? 'Yes' : 'No'
  end
  
  def default_project
    self.is_default ? 'Yes' : 'No'
  end
  
  def is_default_val
    self.is_default ? 0 : 1
  end
  
  def sort_name
    return '00000000000000000000000000000' if self.is_default?
    
    name
  end
end
