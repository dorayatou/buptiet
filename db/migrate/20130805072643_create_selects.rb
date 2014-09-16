class CreateSelects < ActiveRecord::Migration
  def change
    create_table :selects do |t|
    	t.integer :offer_id
    	t.integer :student_id
      t.timestamps
    end
  end
end
