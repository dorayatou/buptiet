class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    	t.integer :problem_id
    	t.integer :student_id
    	t.text :body

      t.timestamps
    end
  end
end
