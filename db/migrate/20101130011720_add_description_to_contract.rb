class AddDescriptionToContract < ActiveRecord::Migration
  def self.up
    add_column :contracts, :description, :string
  end

  def self.down
    remove_column :contracts, :description
  end
end
