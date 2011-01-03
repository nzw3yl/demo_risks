class AddEffortToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :effort, :integer
  end

  def self.down
    remove_column :assignments, :effort
  end
end
