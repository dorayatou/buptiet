class CreateBuptfavorites < ActiveRecord::Migration
  def change
    create_table :buptfavorites, :primary_key => :buptfavo_id do |t|
    	t.text :user_name
    	t.integer :buptcourse_id
    	t.text :course_name
    	t.text :favo_time

      t.timestamps
    end
  end
end
