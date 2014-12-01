#encoding: utf-8
class Topic < ActiveRecord::Base
	# 话题与观点的一对多关系
	has_many :opinions, dependent: :destroy
	# 话题与选票的一对多关联
	has_many :votes
	# 观点与教师的关联
	belongs_to :teacher
	
	
    attr_accessible :teacher_id, :student_id, :body, :cast_count

    def opinion_ids
  		opinions.map(&:id)
  	end

  	def result_a
  		opinion_id = self.opinions[0]
  		if opinion_id
  			Opinion.find(opinion_id).select_count	
  		else
  			0
  		end
  	end

  	def result_b
  		opinion_id = self.opinions[1]
  		if opinion_id
  			Opinion.find(opinion_id).select_count	
  		else
  			0
  		end	
  	end

	def result_c
  		opinion_id = self.opinions[2]
  		if opinion_id
  			Opinion.find(opinion_id).select_count	
  		else
  			0
  		end	
  	end

  	def result_d
  		opinion_id = self.opinions[3]
  		if opinion_id.present?
  			Opinion.find(opinion_id).select_count	
  		else
  			0
  		end
  	end

end
