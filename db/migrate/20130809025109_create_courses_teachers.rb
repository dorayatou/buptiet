class CreateCoursesTeachers < ActiveRecord::Migration
  def up
  	create_table :courses_teachers, :id => false do |t|
  		t.integer :course_id, :null => false
  		t.integer :teacher_id, :null => false
  		t.integer :offer_id, :null => false
  		t.integer :schedule_id, :null => false

  		t.timestamps
  	end
  end

  def down
  	drop_table :courses_teachers
  end

end
