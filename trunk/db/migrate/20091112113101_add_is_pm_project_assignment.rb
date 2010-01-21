class AddIsPmProjectAssignment < ActiveRecord::Migration
  def self.up
    add_column :project_assignments, :is_pm, :boolean, :default => false
  end

  def self.down
  end
end
