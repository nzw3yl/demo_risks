class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :work_load_id

      t.timestamps
    end
    add_index :assignments, :user_id
    add_index :assignments, :work_load_id
  end

  def self.down
    drop_table :assignments
  end
end
