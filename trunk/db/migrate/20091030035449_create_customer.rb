class CreateCustomer < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.text :description
      t.string :code
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
