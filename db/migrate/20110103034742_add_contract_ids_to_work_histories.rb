class AddContractIdsToWorkHistories < ActiveRecord::Migration
  def self.up
    add_column :work_histories, :contract_ids, :string
  end

  def self.down
    remove_column :work_histories, :contract_ids
  end
end
