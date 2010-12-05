class RemoveTypeFromContract < ActiveRecord::Migration
  def self.up
    remove_column :contracts, :type
  end

  def self.down
    add_column :contracts, :type, :string
  end
end
