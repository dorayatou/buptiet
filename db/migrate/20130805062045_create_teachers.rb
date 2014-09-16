class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
    	t.string :identifier
    	t.string :password
    	
     	t.timestamps
    end

    create_table :teacher_infos do |t|
    	 t.integer :teacher_id
       t.integer :academy_id
    	 t.string :nick
      	t.string :name
      	t.string :email
      	
      	t.timestamps
    end 
        
  end
end
