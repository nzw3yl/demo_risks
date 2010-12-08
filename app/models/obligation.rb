# == Schema Information
# Schema version: 20101208035029
#
# Table name: obligations
#
#  id           :integer         not null, primary key
#  contract_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  work_load_id :integer
#

class Obligation < ActiveRecord::Base
  attr_accessible :contract_id, :work_load_id
  
  belongs_to :work_loads, :foreign_key => "work_load_id"
  belongs_to :contracts, :foreign_key => "contract_id"
end
