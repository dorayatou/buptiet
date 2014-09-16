class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :identifier
    	t.integer :course_id
    	t.integer :teacher_id
      
    	t.string :address
    	t.date :begin 
    	t.date :end


      t.timestamps
    end
  end
end
