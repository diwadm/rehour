class TimesheetEntry < ActiveRecord::Base
  belongs_to :project_assignment
  
  validates_presence_of :project_assignment_id
  validates_presence_of :entry_date
  
  # def validate
  #   if self.hours and self.hours > project_assignment.remaining_hours 
  #     errors.add(:hours, 'overrun')
  #   end
  # end
  
  def validate
    if self.hours and self.hours <= 0
      errors.add(:hours, 'must be greater than 0')
    end
  end
  
  def self.create_or_save(assignment_id, date_entry, hours, comment)
    if timesheet_entry = TimesheetEntry.find_by_project_assignment_id_and_entry_date(assignment_id, date_entry)
      timesheet_entry.update_attributes(:hours => hours, :comment => comment)
    else
      timesheet_entry = TimesheetEntry.new({:project_assignment_id => assignment_id, :entry_date => date_entry, :hours => hours, :comment => comment})
      timesheet_entry.save
    end
    
    return timesheet_entry
  end
  
  def self.normal_find(assignment_id, date_entry, hours, comment)
    TimesheetEntry.find_by_project_assignment_id_and_entry_date(assignment_id, date_entry)
  end
  
  def self.entries_for_the_day(user_id, date)
    TimesheetEntry.find(:all, :conditions => ["project_assignments.user_id = ? AND timesheet_entries.entry_date = ?",  user_id, date], :joins => "JOIN project_assignments ON (timesheet_entries.project_assignment_id = project_assignments.id)", :select => "timesheet_entries.*") 
  end
  
  def hours?
    (self.hours and self.hours > 0) ? self.hours : nil
  end
end
