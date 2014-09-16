class CreateBuptcomments < ActiveRecord::Migration
  def change
    create_table :buptcomments, :primary_key => :buptcomment_id do |t|
    	t.integer :buptcourse_id, default: 0
    	t.integer :buptlesson_id, default: 0
    	t.text :user_name
    	t.text :comment_content
    	t.text :comment_time

      t.timestamps
    end
  end
end
