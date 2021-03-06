class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :alias
      t.string :name
      t.text :description
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
