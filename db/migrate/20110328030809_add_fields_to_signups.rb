class AddFieldsToSignups < ActiveRecord::Migration
  def self.up
    add_column :signups, :tshirt_size, :string
    add_column :signups, :location, :string
  end

  def self.down
    remove_column :signups, :tshirt_size
    remove_column :signups, :location
  end
end
