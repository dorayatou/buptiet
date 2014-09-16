class CreateIqTests < ActiveRecord::Migration
  def change
    create_table :iq_tests do |t|
    	t.string :question_num
    	t.string :question_item
    	t.string :score_item
    	t.integer :score 
    	t.string :consume_time

      t.timestamps
    end
  end
end
