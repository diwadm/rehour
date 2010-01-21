class CreateProject < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :customer
      t.string :name
      t.text :description
      t.string :contact
      t.string :project_code
      t.boolean :is_active, :default => true
      t.boolean :is_billable, :default => true
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
