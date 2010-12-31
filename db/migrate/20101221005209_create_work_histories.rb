class CreateWorkHistories < ActiveRecord::Migration
  def self.up
    create_table :work_histories do |t|
      t.integer :work_load_id
      t.integer :effort
      t.date :occurrence_date
      t.integer :user_id
      t.string :work_load_name
      t.string :contract_name
      t.integer :priority
      t.string :work_load_type_name

      t.timestamps
    end
  end

  def self.down
    drop_table :work_histories
  end
end
