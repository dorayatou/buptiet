class Student < ActiveRecord::Base
	  has_one :student_info, dependent: :destroy
    # 学生与教师的多对多关系
    has_and_belongs_to_many :teachers  
    # 学生与课程的多对多关系
    has_and_belongs_to_many :courses
    # 学生与群组的多对多关系
    has_and_belongs_to_many :groups
    # 学生与问题的一对多关系
    has_many :problems
    # 学生与所发微博的一对多关系
    has_many :posts, :order => "created_at DESC", :dependent => :destroy
    # 学生与试题答案的一对多关联
    has_many :answers
    # 学生与练习的一对多关联
    has_many :quizzes, class_name: "exercises"

    attr_accessible :identifier, :password, :password_confirmation
	  # attr_accessible :identifier, :hashed_password, :salt
  	# attr_accessible :password,   :password_confirmation

  	# attr_reader   :password
  	attr_accessor :password_confirmation

  	# validates :identifier, :presence => true, :uniqueness => true
  	# validates :password, :confirmation => true

  	# validate :password_must_be_present

  	def Student.authenticate(identifier, password)
  		if student = find_by_identifier(identifier)
  			if student.password == password
  				student
  			end
  		end
  	end

  	# def Student.encrypt_password(password, salt)
  	# 	Digest::SHA2.hexdigest(password + "wibble" + salt)
  	# end

  	# def password=(password)
  	# 	@password = password
  	# 	if password.present?
  	# 		generate_salt
  	# 		self.hashed_password = self.class.encrypt_password(password, salt)
  	# 	end
  	# end
    # 判读学生是否选择了某门课程
    def enrolled_in?(course)
      self.courses.include?(course)
    end

  	def clear_password!
    	self.password = nil
    	self.password_confirmation = nil
  	end

  	def login!(session)
    	session[:student_id] = self.id
  	end
  #private method only can be used by student.rb#
 	 # private

  	# def password_must_be_present
  	# 	errors.add(:password, "Missing password") unless hashed_password.present?
  	# end

  	# def generate_salt
  	# 	self.salt = self.object_id.to_s + rand.to_s
  	# end

end
