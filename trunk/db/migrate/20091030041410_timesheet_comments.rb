class TimesheetComments < ActiveRecord::Migration
  def self.up
    create_table :timesheet_comments do |t|
      t.references :user
      t.comment_date :date
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :timesheet_comments
  end
end
