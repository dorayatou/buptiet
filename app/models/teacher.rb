class Teacher < ActiveRecord::Base
	has_one :teacher_info, dependent: :destroy
  # 教师与学生的多对多关系
  has_and_belongs_to_many :students
  # 教师与课程的多对多关系
  has_many :offers, dependent: :destroy
  has_many :courses, through: :offers
  # 教师与群组的一对多关系
  has_many :groups
  # 教师与随堂测试的一对多关系
  has_many :quizzes
  # 教师与话题（投票）的一对多关系
  has_many :topics
  # 教师与微博的一对多关系
  has_many :posts, :order => "created_at DESC", :dependent => :destroy
  # 教师与问题的一对多关系
  has_many :problems
  
  attr_accessible :identifier, :password, :password_confirmation

	# attr_accessible :identifier, :hashed_password, :salt
 #  attr_accessible :password,   :password_confirmation

 #  	attr_reader   :password
  	attr_accessor :password_confirmation

  	# validates :identifier, :presence => true, :uniqueness => true
  	# validates :password, :confirmation => true

 	# validate :password_must_be_present



  	def Teacher.authenticate(identifier, password)
  		if teacher = find_by_identifier(identifier)
  			if teacher.password == password
  				teacher
  			end
  		end
  	end

  	# def Teacher.encrypt_password(password, salt)
  	# 	Digest::SHA2.hexdigest(password + "wibble" + salt)
  	# end

  	# def password=(password)
  	# 	@password = password
  	# 	if password.present?
  	# 		generate_salt
  	# 		self.hashed_password = self.class.encrypt_password(password, salt)
  	# 	end
  	# end

  	# private

  	# def password_must_be_present
  	# 	errors.add(:password, "Missing password") unless hashed_password.present?
  	# end

  	# def generate_salt
  	# 	self.salt = self.object_id.to_s + rand.to_s
  	# end
end
