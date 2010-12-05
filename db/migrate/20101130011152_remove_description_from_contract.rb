class RemoveDescriptionFromContract < ActiveRecord::Migration
  def self.up
    remove_column :contracts, :description
  end

  def self.down
    add_column :contracts, :description, :text
  end
end
