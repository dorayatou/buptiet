class AddCourseIdToProblems < ActiveRecord::Migration
  def change
		add_column :problems, :course_id, :integer
		remove_column :problems, :teacher_id, :integer
	end
end
