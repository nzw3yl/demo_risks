class CreateObligations < ActiveRecord::Migration
  def self.up
    create_table :obligations do |t|
      t.integer :contract_id
      t.integer :workload_id

      t.timestamps
    end
    add_index :obligations, :contract_id
    add_index :obligations, :workload_id
  end

  def self.down
    drop_table :obligations
  end
end
