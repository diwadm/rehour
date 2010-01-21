class AddDefaultProjectProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :is_default, :boolean, :default => false
  end

  def self.down
    remove_column :is_default
  end
end
