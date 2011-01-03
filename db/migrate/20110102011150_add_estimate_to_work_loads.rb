class AddEstimateToWorkLoads < ActiveRecord::Migration
  def self.up
    add_column :work_loads, :estimate, :integer
  end

  def self.down
    remove_column :work_loads, :estimate
  end
end
