class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
    	t.integer :course_id
    	t.integer :student_id
    	t.text :grade

      t.timestamps
    end
  end
end
