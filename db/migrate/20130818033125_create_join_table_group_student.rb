class CreateJoinTableGroupStudent < ActiveRecord::Migration
  def up
  	create_table :groups_students, :id => false do |t|
  		t.integer :group_id
  		t.integer :student_id
  	end
  end

  def down
  	drop_table :groups_students
  end
end
