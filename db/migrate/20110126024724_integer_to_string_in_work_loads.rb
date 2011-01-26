class IntegerToStringInWorkLoads < ActiveRecord::Migration
  def self.up
     change_column :work_loads, :priority, :string
  end

  def self.down
    change_column :work_loads, :priority, :integer
  end
end
