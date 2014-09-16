class TeacherInfo < ActiveRecord::Base
	belongs_to :teacher

   	attr_accessible :teacher_id, :nick, :name, :email, :academy_id
end
