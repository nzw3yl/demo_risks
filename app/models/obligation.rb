# == Schema Information
# Schema version: 20110102020136
#
# Table name: obligations
#
#  id           :integer         not null, primary key
#  contract_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  work_load_id :integer
#  effort       :decimal(, )
#

class Obligation < ActiveRecord::Base
  attr_accessible :contract_id, :work_load_id, :effort
  belongs_to :work_load
  belongs_to :contract

  def update_effort(new_effort)
    self.effort = new_effort
    self.save!
  end

end
