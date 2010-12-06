class AddContractTypeIdToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :contract_type_id, :integer
  end

  def self.down
    remove_column :contracts, :contract_type_id
  end
end
