class Box < ActiveRecord::Base
	# 投票箱与选票的一对多关系
	has_many :votes, dependent: :destroy
  # 投票箱与话题的关联
  belongs_to :topics
	
  	# attr_accessible :title, :body

  	def add_opinion(opinion_id)
  		current_vote = votes.find_by_opinion_id(opinion_id)
  		if current_vote
  			current_vote.quantity += 1
  		else
  			current_vote = votes.build(:opinion_id => opinion_id)
  		end
  		current_vote
  	end
  	
end
