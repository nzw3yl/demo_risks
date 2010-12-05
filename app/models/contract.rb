class Contract < ActiveRecord::Base
  attr_accessible :name, :description, :alias

  validates :name,     :presence     => true,
                       :length       => { :maximum => 50 }
  validates :alias,    :presence     => true,
                       :length       => { :within => 1..10 },
                       :uniqueness   => { :case_sensitive => false }

 
end
