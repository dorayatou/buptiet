class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :student_id
    	t.integer :topic_id
    	t.integer :opinion_id
    	
    	

      t.timestamps
    end
  end
end
