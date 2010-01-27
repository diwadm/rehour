#ActiveRecord::Base.logger = Logger.new(STDOUT)
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  alias_attribute :first_name, :name

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_length_of       :last_name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  validates_presence_of :department_id, :message => 'is required'

  default_scope :order => 'login ASC'

  belongs_to :department
  has_many :project_assignments, :dependent => :destroy
  has_many :projects, :through => :project_assignments
  has_many :timesheet_comments, :dependent => :destroy
  has_many :user_assignments, :dependent => :destroy
  has_many :user_roles, :through => :user_assignments
  
  #has_many :user_to_user_roles
  attr_accessible :user_to_user_roles, :user_to_user_roles_values
  
  # this virtual attribute saves temporarily the roles for this particular user
  attr_accessor :user_to_user_roles_values
  
  after_save :save_project_assignments
  def save_project_assignments
    if user_to_user_roles_values
      for user_role in user_to_user_roles_values
        # don't insert a new record if the role exists
        unless UserAssignment.find_by_user_role_id_and_user_id(user_role, id)
          UserAssignment.new({:user_role_id => user_role, :user_id => id}).save
        end
      end
    end
  end
  
  after_create :add_default_projects
  def add_default_projects
    Project.default.each { |project| project.set_assignments_for_default_project }
  end
  
  named_scope :active, :conditions => {:is_active => true}, :order => 'login'
  named_scope :inactive, :conditions => {:is_active => false}, :order => 'login'

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :last_name, :department_id
  
  def active
    self.is_active ? 'Yes' : 'No'
  end
  
  def roles
    user_roles
  end
  
  def roles_ids
    self.user_roles.collect { |c| c.id }
  end
  
  def user_to_user_roles
    ProjectAssignment.find_all_by_user_id(id) if id
  end
  
  def user_to_user_roles=(value)
    self.user_to_user_roles_values = value
  end
  
  def is_admin?
    self.roles.each{ |r| return true if r.name == 'Admin' }
    false
  end
  
  def is_consultant?
    self.roles.each{ |r| return true if r == 'Consultant' }
    false
  end
  
  def is_pm?
    self.roles.each{ |r| return true if r == 'Project Manager' }
    false
  end
  
  def is_report_user?
    self.roles.each{ |r| return true if r == 'Report' }
    false
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def projects_by_customers
    customers = {}
    for project in projects
      customers[project.customer_id] ||= []
      customers[project.customer_id] << project
    end
    
    customers
  end
  
  def project_assignments_by_customers
    customers = {}
    
    # re-arrange the projects on a per customer basis
    for assignment in project_assignments
      customers[assignment.project.customer_id] ||= []
      customers[assignment.project.customer_id] << assignment
    end
    
    # sort the customer's project alphabetically
    customers.each { |customer_id, assignments|
      customers[customer_id] = assignments.sort { |x, y| x.project.sort_name <=> y.project.sort_name }
    }
    
    # finally, sort the customers hash according to the customer name alphabetically
    # note: calling sort() on a hash results to a conversion of each element to an array
    # that's why we referenced the project's customer via "x.last.last".
    # example:
    # >> h = {10 => "ten", 1 => "one", 5 => "five"}
    # => {5=>"five", 1=>"one", 10=>"ten"}
    # >> h.sort
    # => [[1, "one"], [5, "five"], [10, "ten"]]
    customers = customers.sort { |x, y| x.last.last.project.customer.name <=> y.last.last.project.customer.name }
    
    customers
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
