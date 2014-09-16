class FileServes < ActiveRecord::Migration
  def change
    create_table :file_serves do |t|
    	t.integer :course_id
      	t.string  :title
      	t.string  :file_name
      	t.string  :file_url

      	t.timestamps
    end
  end
end
