class AdminInfo < ActiveRecord::Base
  belongs_to :admin
  attr_accessible :admin_id, :email, :name
end
