# == Schema Information
# Schema version: 20101207011704
#
# Table name: work_loads
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  alias             :string(255)
#  description       :string(255)
#  probability       :integer
#  impact            :integer
#  priority          :integer
#  status            :string(255)
#  percent_complete  :integer
#  resolution_effort :integer
#  workload_type_id  :integer
#  requested_date    :date
#  expected_date     :date
#  completed_date    :date
#  created_at        :datetime
#  updated_at        :datetime
#

class WorkLoad < ActiveRecord::Base
   has_many :obligations 
   has_many :contracts, :through => :obligations       
attr_accessible :name, :alias, :description, :probability, :impact, :contract_ids,
                :priority, :status, :percent_complete, :resolution_effort, 
                :workload_type_id, :requested_date, :expected_date, :completed_date
   attr_accessor   :contract_ids

   after_save :update_contracts

   def update_contracts
     unless contract_ids.nil?
       self.obligations.each do |o|
         o.destroy unless contract_ids.include?(o.contract_id.to_s)
         contract_ids.delete(o.contract_id.to_s)
       end
       contract_ids.each do |c|
         self.obligations.create!(:contract_id => c) unless c.blank?
       end
       reload
       self.contract_ids = nil
     end
   end




end
