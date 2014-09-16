class FindingToneScore < ActiveRecord::Migration
  def change
    create_table :finding_tone_scores do |t|
    	t.text :target_tone_char
    	t.text :compare_tone_char
    	t.integer :consume_time
    	t.boolean :correct

      t.timestamps
    end
  end
end
