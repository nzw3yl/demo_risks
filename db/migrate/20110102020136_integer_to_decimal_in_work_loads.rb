class IntegerToDecimalInWorkLoads < ActiveRecord::Migration
  def self.up
    change_column :work_loads, :resolution_effort, :decimal , :precision => 7, :scale => 2
    change_column :work_loads, :estimate, :decimal , :precision => 7, :scale => 2
    change_column :assignments, :effort, :decimal , :precision => 7, :scale => 2
    change_column :obligations, :effort, :decimal , :precision => 7, :scale => 2
    change_column :work_histories, :effort, :decimal , :precision => 7, :scale => 2
  end

  def self.down
    change_column :work_loads, :resolution_effort, :integer
    change_column :work_loads, :estimate, :integer
    change_column :assignments, :effort, :integer
    change_column :obligations, :effort, :integer
    change_column :work_histories, :effort, :integer
  end
end
