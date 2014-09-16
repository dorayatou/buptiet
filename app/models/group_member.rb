class GroupMember < ActiveRecord::Base
	belongs_to :group
  # attr_accessible :title, :body
end
