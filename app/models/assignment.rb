# == Schema Information
# Schema version: 20101208221204
#
# Table name: assignments
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  work_load_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Assignment < ActiveRecord::Base
  attr_accessible :user_id, :work_load_id
  belongs_to :user
  belongs_to :work_load

end
