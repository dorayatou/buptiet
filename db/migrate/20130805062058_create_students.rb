class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :identifier
    	t.string :password
    	
        t.timestamps
    end

    create_table :student_infos do |t|
    	t.integer :student_id
    	t.string :nick
      	t.string :name
      	t.string :email
      	t.integer :academy_id
      
      	t.timestamps
    end
  end
end
