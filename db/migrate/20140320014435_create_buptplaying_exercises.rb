class CreateBuptplayingExercises < ActiveRecord::Migration
  def change
   create_table :buptplaying_exercises, :primary_key => :buptplaying_exercise_id do |t|
    	t.integer :buptlesson_id
    	t.text :question_type
    	t.integer :question_num
    	t.integer :pause_time
    	t.text :question
    	t.text :option_a
    	t.text :option_b
    	t.text :option_c
    	t.text :option_d
    	t.text :answer
    	t.text :analysis

      t.timestamps
    end
  end
end
