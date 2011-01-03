# == Schema Information
# Schema version: 20110103034742
#
# Table name: work_histories
#
#  id                  :integer         not null, primary key
#  work_load_id        :integer
#  effort              :decimal(, )
#  occurrence_date     :date
#  user_id             :integer
#  work_load_name      :string(255)
#  contract_name       :string(255)
#  priority            :integer
#  work_load_type_name :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  contract_ids        :string(255)
#

class WorkHistory < ActiveRecord::Base
attr_accessible :work_load_id, :effort, :occurrence_date, :user_id, :work_load_name, :contract_name, :priority, :work_load_type_name
belongs_to :work_load

end
