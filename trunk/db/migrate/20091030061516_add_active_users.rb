class AddActiveUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_active, :boolean, :default => true
  end

  def self.down
  end
end
