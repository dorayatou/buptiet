class CreateAnswerStudentLists < ActiveRecord::Migration
  def change
    create_table :answer_student_lists do |t|
      t.integer :problem_id
			t.integer :student_id

      t.timestamps
    end
  end
end
