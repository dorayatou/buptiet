class CreateImageCourses < ActiveRecord::Migration
  def change
    create_table :image_courses do |t|
    	t.string :question_num
    	t.string :question_item
    	t.string :score_item
    	t.integer :score 

      t.timestamps
    end
  end
end
