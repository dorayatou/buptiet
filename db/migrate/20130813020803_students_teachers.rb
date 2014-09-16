class StudentsTeachers < ActiveRecord::Migration
  def up
  	create_table :students_teachers, :id => false do |t|
  		t.integer :teacher_id
  		t.integer :student_id

  		t.timestamps
  	end
  end

  def down
  	drop_table :students_teacher
  end
end
