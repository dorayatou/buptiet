class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.integer :academy_id
      t.string :identifier
    	t.string :name
    	
    	t.string :info
    	t.string :image
    	t.string :tag
    	t.string :kind

      t.timestamps
    end
  end
end
