class AddCommentDateTimesheetComments < ActiveRecord::Migration
  def self.up
    add_column :timesheet_comments, :comment_date, :date
  end

  def self.down
  end
end
