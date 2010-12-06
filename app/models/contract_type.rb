# == Schema Information
# Schema version: 20101206005744
#
# Table name: contract_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ContractType < ActiveRecord::Base
  attr_accessible :name

  has_many :contracts
end
