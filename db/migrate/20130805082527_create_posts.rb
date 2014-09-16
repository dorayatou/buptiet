class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.integer :teacher_id
    	t.integer :student_id
    	t.integer :group_id
    	t.string :title
    	t.text :body

      t.timestamps
    end
  end
end
