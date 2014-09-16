class AddQuizIdToReport < ActiveRecord::Migration
  def change
  	add_column :reports, :quiz_id, :integer
  end
end
