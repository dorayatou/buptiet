class CreateQuizzes < ActiveRecord::Migration
  def change
  	create_table :quizzes do |t|
  		t.integer :course_id
      t.integer :teacher_id
      t.string :quiz_type
      t.integer :seq
      t.string :name
      t.integer :quiz_time
  		t.integer :week_total
      
  		t.timestamps
  	end

  	create_table :questions do |t|
  		t.integer :quiz_id
  		t.string :question_type
  		t.text :body
      t.integer :total_num, :default => 0
      t.integer :correct_num, :default => 0
      t.boolean :fav_flag, :default => 'f'

  		t.timestamps
  	end

  	create_table :options do |t|
  		t.integer :question_id
  		t.text :body
  		t.boolean :correct, :default => 'f'
      t.integer :select_num, :default => 0

  		t.timestamps
  	end

  	create_table :answers do |t|
  		t.integer :student_id
      t.integer :quiz_id
  		t.integer :question_id
  		t.integer :option_id
  		t.boolean :correct, :default => 'f'
      t.boolean :fav_flag, :default => 'f'

  		t.timestamps
  	end

  	create_table :analyses do |t|
  		t.integer :question_id
  		t.text :body
      t.text :detail

  		t.timestamps
  	end

  end
end
