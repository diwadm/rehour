module Consultant::OverviewHelper
  def day_links(date)
    day_links = {}
    1.upto(31) { |d|
      day_links[d] = link_to(d, :action => 'book', :year => date.year, :month => date.month, :day => d)
    }
    
    day_links
  end
  
  def book_id_name(current_date, assignment_id)
    "book_#{current_date.month}_#{current_date.day}_#{current_date.year}_#{assignment_id}"
  end
  
  def comment_date_id_name(current_date, user_id)
    "comment_#{current_date.month}_#{current_date.day}_#{current_date.year}_#{user_id}"
  end
  
  def assignment_message_id(assignment_id)
    "assignment_message_#{assignment_id}"
  end
  
  def error_assignment_message_id(assignment_id)
    "error_assignment_message_#{assignment_id}"
  end
  
  def render_calendar_cell(date, day)
    links_for_days = day_links(date)
    
    current_date = "#{date.year}-#{date.month}-#{day.mday}"
    logger.info "current_date #{current_date}"
    timesheet_entries = TimesheetEntry.entries_for_the_day(self.current_user.id, current_date)
    
    html = ""
    
    for timesheet_entry in timesheet_entries 
      hours = timesheet_entry.hours?

      if hours and hours > 0 
        html += %{#{timesheet_entry.project_assignment.project.project_code} - #{number_format(hours)}<br />}
      end 
    end 
    ["#{links_for_days[day.mday.to_i]}<br /> #{html}"]
  end
  
  def sort_assignments(project_assignments)
    project_assignments.sort { |x,y| x.project.name <=> y.project.name }
  end
  
  def assignment_comment_id(comment_date, assignment_id)
    "assignment_comment_#{comment_date.year}_#{comment_date.month}_#{comment_date.day}_#{assignment_id}"
  end
  
  def assignment_comment_text_box_id(current_date, assignment_id)
    "comment-text_#{current_date.year}_#{current_date.month}_#{current_date.day}_#{assignment_id}"
  end
  
  def sql_date(date)
    "#{date.year}-#{date.month}-#{date.day}"
  end
  
  def week_dates(week_num)
    date_format(week_start(week_num)) + ' - ' + date_format(week_end(week_num))
  end
  
  def week_start(week_num)
    year = Time.now.year
    begin
      first_date_of_the_week = Date.commercial(year, week_num, 1)
    rescue
      week_num = 1
      first_date_of_the_week = Date.commercial(year, week_num, 1)
    end
    
    first_date_of_the_week
  end
  
  def week_end(week_num)
    year = Time.now.year
    begin
      last_date_of_the_week = Date.commercial(year, week_num, 7)
    rescue
      week_num = 1
      last_date_of_the_week = Date.commercial(year, week_num, 7)
    end
    
    last_date_of_the_week
  end
  
  def is_book_param?(param_name)
    !param_name.split('_').blank? and param_name.split('_')[0] == 'book' ? true : false
  end
  
  def determine_comment_param(param_name)
    "comment-text_#{book_year(param_name)}_#{book_month(param_name)}_#{book_day(param_name)}_#{book_assignment_id(param_name)}"
  end
  
  def book_month(param_name)
    param_name.split('_')[1]
  end
  
  def book_day(param_name)
    param_name.split('_')[2]
  end
  
  def book_year(param_name)
    param_name.split('_')[3]
  end
  
  def book_assignment_id(param_name)
    param_name.split('_')[4]
  end
  
  def book_date(param_name)
    "#{book_year(param_name)}-#{book_month(param_name)}-#{book_day(param_name)}"
  end
end
