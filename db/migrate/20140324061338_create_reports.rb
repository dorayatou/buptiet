class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
    	t.integer :student_id
    	t.string :course_name
    	t.string :learning_time

      t.timestamps
    end
  end
end
