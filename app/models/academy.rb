class Academy < ActiveRecord::Base
	has_many :courses
	attr_accessible :identifier, :name
  
  	# validates :identifier, :presence => true, :uniqueness => true
  	# validates :name, :presence => true, :uniqueness => true  
end
