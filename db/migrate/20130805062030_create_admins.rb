class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
    	t.string :identifier
    	t.string :password
    
      	t.timestamps
    end
    create_table :admin_infos do |t|
    	t.integer :admin_id
    	t.string :name
    	t.string :email
    	t.timestamps
    end
  end
end
