class OfferDate < ActiveRecord::Base
	# 授课时间与授课的多对多关系
	has_and_belongs_to_many :offers
	
  # attr_accessible :title, :body
end
