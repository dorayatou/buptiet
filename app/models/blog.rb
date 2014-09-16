class Blog < ActiveRecord::Base
	belongs_to :student
	belongs_to :teacher
	belongs_to :group
end
