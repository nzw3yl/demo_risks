class RemoveWorkloadIdFromObligations < ActiveRecord::Migration
  def self.up
    remove_column :obligations, :workload_id
  end

  def self.down
    add_column :obligations, :workload_id, :integer
  end
end
