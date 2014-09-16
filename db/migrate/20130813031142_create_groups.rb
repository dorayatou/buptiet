class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.integer :teacher_id
    	t.integer :course_id
    	t.integer :academy_id
    	t.string :kind
    	t.string :identifier
    	t.string :name
    	t.text :intro
    	t.text :tag

      t.timestamps
    end
  end
end
