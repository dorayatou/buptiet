class CreateOpenCurrentQuestions < ActiveRecord::Migration
  def change
    create_table :open_current_questions do |t|
			t.integer  :quiz_id
			t.integer  :question_id

      t.timestamps
    end
  end
end
