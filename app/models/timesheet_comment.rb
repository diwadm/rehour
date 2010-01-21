class TimesheetComment < ActiveRecord::Base
  belongs_to :user
  
  def self.create_or_save(user_id, comment_date, comment)
    if timesheet_comment = TimesheetComment.find_by_user_id_and_comment_date(user_id, comment_date)
      timesheet_comment.update_attributes({:user_id => user_id, :comment_date => comment_date, :comment => comment})
    else
      TimesheetComment.new({:user_id => user_id, :comment_date => comment_date, :comment => comment}).save
    end
  end
  
  def comment?
    self.comment ? self.comment : ''
  end
end
