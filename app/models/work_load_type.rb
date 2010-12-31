# == Schema Information
# Schema version: 20101220021835
#
# Table name: work_load_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class WorkLoadType < ActiveRecord::Base
  attr_accessible :name

  has_many :work_loads
end
