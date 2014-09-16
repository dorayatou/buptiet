class PlayingToneScore < ActiveRecord::Migration
  def change
  	create_table :playing_tone_scores do |t|
    	t.text :target_tone_char
    	t.integer :consume_time
    	t.boolean :correct
    	t.text :selected_tone_char

      t.timestamps
    end
  end
end
