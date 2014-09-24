class CreateProblemStudents < ActiveRecord::Migration
  def change
    create_table :problem_students do |t|
      t.integer :problem_id
			t.integer :student_id

      t.timestamps
    end
  end
end
