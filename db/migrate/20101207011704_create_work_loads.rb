class CreateWorkLoads < ActiveRecord::Migration
  def self.up
    create_table :work_loads do |t|
      t.string :name
      t.string :alias
      t.string :description
      t.integer :probability
      t.integer :impact
      t.integer :priority
      t.string :status
      t.integer :percent_complete
      t.integer :resolution_effort
      t.integer :workload_type_id
      t.date :requested_date
      t.date :expected_date
      t.date :completed_date

      t.timestamps
    end
    add_index :work_loads, :alias
    add_index :work_loads, :name
    add_index :work_loads, :completed_date
    add_index :work_loads, :workload_type_id
  end

  def self.down
    drop_table :work_loads
  end
end
