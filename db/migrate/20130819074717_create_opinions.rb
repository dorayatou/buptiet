class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
    	t.integer :topic_id
    	t.string  :body
    	t.integer :select_count, :default => 0

      t.timestamps
    end
  end
end
