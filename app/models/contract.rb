# == Schema Information
# Schema version: 20101130022440
#
# Table name: contracts
#
#  id          :integer         not null, primary key
#  alias       :string(255)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#

class Contract < ActiveRecord::Base
  attr_accessible :name, :description, :alias, :contract_type_id

  validates :name,     :presence     => true,
                       :length       => { :maximum => 50 }
  validates :alias,    :presence     => true,
                       :length       => { :within => 1..10 },
                       :uniqueness   => { :case_sensitive => false }

  belongs_to :contract_type

  def type_name
    contract_type.name if contract_type
  end
 
end
