# == Schema Information
# Schema version: 20110126024724
#
# Table name: work_loads
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  alias             :string(255)
#  description       :string(255)
#  probability       :integer
#  impact            :integer
#  priority          :string(255)
#  status            :string(255)
#  percent_complete  :integer
#  resolution_effort :decimal(, )
#  work_load_type_id :integer
#  requested_date    :date
#  expected_date     :date
#  completed_date    :date
#  created_at        :datetime
#  updated_at        :datetime
#  estimate          :decimal(, )
#

class WorkLoad < ActiveRecord::Base
    attr_accessible :name, :alias, :description, :probability, :impact, :contract_ids, :user_ids, :status, :percent_complete, :resolution_effort, :work_load_type_id, :requested_date, :expected_date, :completed_date, :estimate

   has_many :obligations, :dependent => :destroy
   has_many :contracts, :through => :obligations
   has_many :assignments, :dependent => :destroy
   has_many :users, :through => :assignments, :validate => false  
   has_many :work_histories
   belongs_to :work_load_type    

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
  
  def set_resolution_effort
       self.resolution_effort = WorkHistory.sum(:effort, :conditions => ['work_load_id = ?', self.id])
       self.save
  end


  private
    
    def  set_priority
      prio = self.probability * self.impact
      if (20..25).include?(prio)
         self.priority = "A"
      elsif (15..19).include?(prio)
         self.priority = "B"
      elsif (8..14).include?(prio)
         self.priority = "C"
      else
         self.priority = "D"
      end
    end

    def set_completed_date
     if self.status_changed? && (self.status == "Closed" || self.status == "Cancelled") 
        self.completed_date = Date.today
     elsif self.status_changed? && self.percent_complete < 100 && (self.status == "Active" || self.status == "Inactive")
         self.completed_date = nil
     end
    end

    def self.search(search)
       if search
         where('name LIKE ?', "%#{search}%")
       else
         scoped
       end
    end

 end
