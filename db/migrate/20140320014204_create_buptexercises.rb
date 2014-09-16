class CreateBuptexercises < ActiveRecord::Migration
  def change
   create_table :buptexercises, :primary_key => :buptexercise_id do |t|
    	t.integer :buptcourse_id
    	t.integer :buptlesson_id
    	t.text :question_type
    	t.integer :question_num
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
