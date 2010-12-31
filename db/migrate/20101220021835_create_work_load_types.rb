class CreateWorkLoadTypes < ActiveRecord::Migration
  def self.up
    create_table :work_load_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :work_load_types
  end
end
