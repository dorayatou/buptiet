class CreateBuptcourses < ActiveRecord::Migration
  def change
    create_table :buptcourses, :primary_key => :buptcourse_id do |t|
    	t.text :course_type
    	t.text :course_name
    	t.text :course_lecturer
    	t.text :course_lecturer_intro
    	t.text :course_intro 
    	t.text :course_image

      t.timestamps
    end
  end
end
