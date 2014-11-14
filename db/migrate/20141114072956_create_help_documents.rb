class CreateHelpDocuments < ActiveRecord::Migration
  def change
    create_table :help_documents do |t|

      t.timestamps
    end
  end
end
