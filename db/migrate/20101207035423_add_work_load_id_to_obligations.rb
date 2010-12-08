class AddWorkLoadIdToObligations < ActiveRecord::Migration
  def self.up
    add_column :obligations, :work_load_id, :integer
    add_index :obligations, :work_load_id
  end

  def self.down
    remove_column :obligations, :work_load_id
  end
end
