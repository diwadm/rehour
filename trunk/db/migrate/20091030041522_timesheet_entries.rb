class TimesheetEntries < ActiveRecord::Migration
  def self.up
    create_table :timesheet_entries do |t|
      t.references :project_assignment
      t.date :entry_date
      t.float :hours
      t.timestamps
    end
  end

  def self.down
  end
end
