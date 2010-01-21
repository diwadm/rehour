class Consultant::OverviewController < ApplicationController
  include ApplicationHelper
  include Consultant::OverviewHelper
  
  layout 'admin'
  
  def index
    params[:displacement] ||= 0
    # 31 days = 1 month
    # advance or regress the current month depending on the displacement
    @date = Date.today + (params[:displacement].to_i * 31)
  end
  
  def book
    @date = Date.parse("#{params[:month]}/#{params[:day]}/#{params[:year]}")
    @current_week = @date.cweek
    @current_week += params[:adjustment].to_i if params[:adjustment]
    
    @week_date_label = week_dates(@current_week)
    
    @week_start = week_start(@current_week)
    @week_end = week_end(@current_week)
  end
  
  def save_book
    @date = Date.parse(params[:date])
    @total_hours = {}
    @comment_id_name = comment_date_id_name(@date, self.current_user.id)
    @error_entries = []
    @assignments = {}
    @has_error = false
    
    # let's try to get the number of hours that was saved before the current week
    # and put it to the virtual attribute temporary_hours for each project assignment.
    # the assignments are in a hash with the project_assignment_id as the key
    params.each { |param_name, hours|
      if is_book_param?(param_name)
        assignment_id = book_assignment_id(param_name)
        project_assignment = ProjectAssignment.find(assignment_id)
        
        @assignments[assignment_id] ||= project_assignment
        @assignments[assignment_id].temporary_hours ||= project_assignment.total_hours_but_not_for(params[:week_start], params[:week_end])
      end
    }

    params.each { |param_name, hours|
      if is_book_param?(param_name)
        hours = hours.to_f
        
        @total_hours[book_assignment_id(param_name)] ||= 0.0
        
        assignment_id = book_assignment_id(param_name)
        comment = params[determine_comment_param(param_name)]
        
        # only restrict saving when the assignment is fixed
        if @assignments[assignment_id].is_fixed? and (timesheet_entry = TimesheetEntry.normal_find(book_assignment_id(param_name), book_date(param_name), hours, comment))
          
          # save the total number of hours if the hours from other weeks (temporary_hours) + hours this week (hours)
          # is still allowed (project_assignment.allotted_hours)
          # otherwise, leave it blank but don't forget to remind the user
          if (@assignments[assignment_id].temporary_hours + hours) > @assignments[assignment_id].allotted_hours
            timesheet_entry.update_attribute(:hours, nil)
            @error_entries << timesheet_entry
            @has_error = true
          
          elsif  (@assignments[assignment_id].temporary_hours + hours) <= @assignments[assignment_id].allotted_hours
            timesheet_entry.update_attribute(:hours, hours)
            @assignments[assignment_id].temporary_hours += timesheet_entry.hours
            @total_hours[assignment_id] += timesheet_entry.hours  
          end

        # we don't need any check for project_assignments that are not-fixed (free flowing :-)
        else
          timesheet_entry = TimesheetEntry.create_or_save(book_assignment_id(param_name), book_date(param_name), hours, comment)  
        end

      end
    }
    
    logger.info "Total Hours #{@total_hours}"
    
    flash[:notice] = "Data saved."
    
    return
  end
end
