class StudentInfo < ActiveRecord::Base
  belongs_to :student

  attr_accessible :id, :student_id, :nick, :name, :email, :academy_id, :classgroup_id
end

