class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :teacher_id
      	t.integer :student_id

      	t.integer :post_id
      	t.integer :comment_id
      
      	t.boolean :read

      t.timestamps
    end
  end
end
