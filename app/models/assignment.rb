# == Schema Information
# Schema version: 20110102020136
#
# Table name: assignments
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  work_load_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  effort       :decimal(, )
#

class Assignment < ActiveRecord::Base
  attr_accessible :user_id, :work_load_id, :effort
  belongs_to :user
  belongs_to :work_load

   def set_effort
       self.effort = WorkHistory.sum(:effort, :conditions => ['work_load_id = ? AND user_id = ?', self.work_load_id, self.user_id])
       self.save
  end
end
