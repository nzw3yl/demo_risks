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
    attr_accessible :name, :alias, :description, :probability, :impact, :contract_ids, :user_ids, :status, :percent_complete, :resolution_effort, :workload_type_id, :requested_date, :expected_date, :completed_date

   has_many :obligations, :dependent => :destroy
   has_many :contracts, :through => :obligations
   has_many :assignments, :dependent => :destroy
   has_many :users, :through => :assignments, :validate => false      

  validates :name,     		:presence     => true,
                       		:length       => { :maximum => 50 },
		       		:uniqueness   => { :case_sensitive => false }
 
  validates :alias,    		:presence     => true,
                       		:length       => { :within => 1..10 },
                       		:uniqueness   => { :case_sensitive => false }

  validates :probability,    	:numericality => true,
                                :inclusion    => { :in => 0..5 }
  
  validates :impact,    	:numericality => true,
	                        :inclusion    => { :in => 0..5 }
  
  validates :percent_complete,	:numericality => true,
  				:inclusion    => { :in => 0..100 }
  
  validates :resolution_effort,	:numericality => true
  
  validates :status,		:inclusion    => { :in => %w(Inactive Active Closed Cancelled)}                    		

  before_save :set_priority, :set_completed_date
  

  private
    
    def  set_priority
      self.priority = self.probability * self.impact
    end

    def set_completed_date
     if self.status_changed? && (self.status == "Closed" || self.status == "Cancelled") 
        self.completed_date = Date.today
     elsif self.status_changed? && self.percent_complete < 100 && (self.status == "Active" || self.status == "Inactive")
         self.completed_date = nil
     end
    end

 end
