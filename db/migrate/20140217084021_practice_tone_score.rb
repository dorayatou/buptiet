class PracticeToneScore < ActiveRecord::Migration
  def change
  	create_table :practice_tone_scores do |t|
  		t.text :first_tone_char
  		t.text :second_tone_char
  		t.integer :consume_time
  		t.boolean :correct
  		t.boolean :is_covered

  		t.timestamps
  	end
  end
end
