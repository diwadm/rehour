class AddDepartmentIdUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :department_id, :integer
  end

  def self.down
  end
end
