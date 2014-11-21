class CreateOpenApiAnswers < ActiveRecord::Migration
  def change
    create_table :open_api_answers do |t|
			t.integer :student_id
      t.integer :quiz_id
  		t.integer :question_id
  		t.integer :option_id
			t.boolean :correct

      t.timestamps
    end
  end
end
