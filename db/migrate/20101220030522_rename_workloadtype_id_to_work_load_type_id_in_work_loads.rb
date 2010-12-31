class RenameWorkloadtypeIdToWorkLoadTypeIdInWorkLoads < ActiveRecord::Migration
  def self.up
    rename_column :work_loads, :workload_type_id, :work_load_type_id
  end

  def self.down
    rename_column :work_loads, :work_load_type_id, :workload_type_id
  end
end
