class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
    	t.integer :teacher_id
    	t.integer :student_id
    	t.text :body   	

      t.timestamps
    end
  end
end
