class CreateBuptlessons < ActiveRecord::Migration
  def change
    create_table :buptlessons, :primary_key => :buptlesson_id do |t|
    	t.integer :buptcourse_id
    	t.integer :lesson_num
    	t.text :lesson_name
    	t.text :lesson_pic
    	t.text :lesson_goal
    	t.text :lesson_difficulty
    	t.text :lesson_website

      t.timestamps
    end
  end
end
