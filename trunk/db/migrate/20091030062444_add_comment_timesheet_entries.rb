class AddCommentTimesheetEntries < ActiveRecord::Migration
  def self.up
    add_column :timesheet_entries, :comment, :string
  end

  def self.down
  end
end
