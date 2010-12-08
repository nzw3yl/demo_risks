# == Schema Information
# Schema version: 20101207011704
#
# Table name: contracts
#
#  id               :integer         not null, primary key
#  alias            :string(255)
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#  contract_type_id :integer
#

class Contract < ActiveRecord::Base
  attr_accessible :name, :description, :alias, :contract_type_id

  validates :name,     :presence     => true,
                       :length       => { :maximum => 50 }
  validates :alias,    :presence     => true,
                       :length       => { :within => 1..10 },
                       :uniqueness   => { :case_sensitive => false }

  has_many   :obligations
  has_many   :work_loads, :through => :obligations
  belongs_to :contract_type

  def type_name
    contract_type.name if contract_type
  end
 
end
