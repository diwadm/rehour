class CreateProjectManagers < ActiveRecord::Migration
  def self.up
    create_table :project_managers, :id => false do |t|
      t.references :project
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :project_managers
  end
end
