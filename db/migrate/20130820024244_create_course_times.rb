class CreateCourseTimes < ActiveRecord::Migration
  def change
    create_table :course_times do |t|
    	t.integer :course_id
      t.string  :weekday
      t.string  :period
    	t.integer :year
    	t.integer :month

      t.timestamps
    end
  end
end
