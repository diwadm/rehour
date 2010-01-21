class AddShortCodeAssignmentTypes < ActiveRecord::Migration
  def self.up
    add_column :assignment_types, :short_code, :string
  end

  def self.down
  end
end
