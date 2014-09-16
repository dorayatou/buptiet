class CreateJoinTableCourseStudent < ActiveRecord::Migration
  def up
  	create_table :courses_students, :id => false do |t|
  		t.integer :course_id, :null => false
  		t.integer :student_id, :null => false
  	end
  end

  def down
  	drop_table :courses_students
  end
end
