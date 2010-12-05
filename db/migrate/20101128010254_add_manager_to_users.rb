class AddManagerToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :manager, :boolean, :default => false
  end

  def self.down
    remove_column :users, :manager
  end
end
