class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :teacher_id
    	t.integer :student_id
    	t.integer :post_id
    	t.string :body

      t.timestamps
    end
  end
end
