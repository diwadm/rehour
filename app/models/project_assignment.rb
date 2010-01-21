class ProjectAssignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :assignment_type
  
  has_many :timesheet_entries, :dependent => :destroy
  
  validates_presence_of :project_id
  validates_presence_of :user_id
  
  validates_presence_of :assignment_type_id
  
  validates_presence_of :allotted_hours, :if => :is_fixed?
  
  attr_accessor :temporary_hours
  
  def validate
    # both dates must be filled if either the start or end was filled by the user
    if date_start and date_end == nil
      errors.add(:date_end, "should not be blank")
    end
    
    if date_end and date_start == nil
      errors.add(:date_start, "should not be blank")
    end
    
    if date_start and date_end and date_start > date_end
  		errors.add(:date_start, "must be less than or equal to the date end")
  	end
  	
  	# sometimes, when the user omits the year, the year drop down changes to 0, +1 (?)
  	# which basically results into catastrophic consequences, e.g. year 0001
  	# so the idea here is to check if the date is a valid date
  	
  	# min and max date needs to be - 10 or + 10 of current year
  	minimum_date = Date.today - (30 * 12 * 10)
  	maximum_date = Date.today + (30 * 12 * 10)
  	
  	if date_start and date_start <= minimum_date
  	  errors.add(:date_start, "can't go below #{minimum_date.year}")
  	end
  	
  	if date_start and date_start >= maximum_date
  	  errors.add(:date_start, "can't go above #{maximum_date.year}")
  	end
  	
  	if date_end and date_end <= minimum_date
  	  errors.add(:date_end, "can't go below #{minimum_date.year}")
  	end
  	
  	if date_end and date_end >= maximum_date
  	  errors.add(:date_end, "can't go above #{maximum_date.year}")
  	end
  end
  
  def active
    self.is_active ? 'Yes' : 'No'
  end
  
  def is_pm?
    self.is_pm ? 'Yes' : 'No'
  end
  
  def role?
    self.role.blank? ? 'N/A' : self.role
  end
  
  def total_hours
    ProjectAssignment.count_by_sql("SELECT SUM(HOURS) FROM timesheet_entries WHERE project_assignment_id = #{self.id}")
  end
  
  def total_hours_but_not_for(start_date, end_date)
    ProjectAssignment.count_by_sql("SELECT SUM(HOURS) FROM timesheet_entries WHERE project_assignment_id = #{self.id} AND  (entry_date < '#{start_date}' OR entry_date > '#{end_date}')")
  end
  
  def billable_hours
    total_hours and self.hourly_rate ? total_hours * self.hourly_rate : 0.0
  end
  
  # todo: put this info a config file
  def is_fixed?
    self.assignment_type_id == 2
  end
  
  # todo: put this info a config file
  def is_flex?
    self.assignment_type_id == 3
  end
  
  def remaining_hours
    is_fixed? and self.allotted_hours and self.allotted_hours > 0 ? self.allotted_hours - self.total_hours : nil
  end
  
  def length
    if date_start == nil and date_end == nil
      return nil
    end
    
    if date_start == date_end
      return 1
    end
    date_end - date_start
  end
end
