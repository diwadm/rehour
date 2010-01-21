class CreateProjectAssignment < ActiveRecord::Migration
  def self.up
    create_table :project_assignments do |t|
      t.references :project
      t.references :user
      t.references :assignment_type
      t.float :hourly_rate
      t.date :date_start
      t.date :date_end
      t.string :role
      t.boolean :is_active, :default => true
      t.float :allotted_hours
      t.float :allotted_hours_overrun
      t.boolean :notify_pm, :default => false
      t.timestamps
    end
  end

  def self.down
  end
end
