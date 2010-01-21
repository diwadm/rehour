class CreateUserAssignments < ActiveRecord::Migration
  def self.up
    create_table :user_assignments do |t|
      t.references :user_role
      t.references :user
    end
  end

  def self.down
    drop_table :user_assignments
  end
end
