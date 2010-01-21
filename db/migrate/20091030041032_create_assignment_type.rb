class CreateAssignmentType < ActiveRecord::Migration
  def self.up
    create_table :assignment_types do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :assignment_types
  end
end
