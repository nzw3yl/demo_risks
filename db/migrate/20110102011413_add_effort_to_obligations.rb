class AddEffortToObligations < ActiveRecord::Migration
  def self.up
    add_column :obligations, :effort, :integer
  end

  def self.down
    remove_column :obligations, :effort
  end
end
