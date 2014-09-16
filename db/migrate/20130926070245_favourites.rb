class Favourites < ActiveRecord::Migration
  def change
  	create_table :favourites do |t|
  		t.integer :student_id
  		t.integer :question_id

  		t.timestamps
  	end
  end
end
