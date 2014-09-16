class Admin < ActiveRecord::Base
	has_one :admin_info, dependent: :destroy
  attr_accessible :identifier, :password, :password_confirmation

	# attr_accessible :identifier, :hashed_password, :salt
 #  	attr_accessible :password,   :password_confirmation

  	# attr_reader   :password
  	 attr_accessor :password_confirmation

  	# validates :identifier, :presence => true, :uniqueness => true
  	# validates :password, :confirmation => true

    def Admin.authenticate(identifier, password)
      if admin = find_by_identifier(identifier)
        if admin.password == password
          admin
        end
      end
    end

  # 	validate :password_must_be_present

  # 	def Admin.authenticate(identifier, password)
  # 		if admin = find_by_identifier(identifier)
  # 			if admin.hashed_password == encrypt_password(password, admin.salt)
  # 				admin
  # 			end
  # 		end
  # 	end

  # 	def Admin.encrypt_password(password, salt)
  # 		Digest::SHA2.hexdigest(password + "wibble" + salt)
  # 	end

  # 	def password=(password)
  # 		@password = password
  # 		if password.present?
  # 			generate_salt
  # 			self.hashed_password = self.class.encrypt_password(password, salt)
  # 		end
  # 	end

 	# private

  # 	def password_must_be_present
  # 		errors.add(:password, "Missing password") unless hashed_password.present?
  # 	end

  # 	def generate_salt
  # 		self.salt = self.object_id.to_s + rand.to_s
  # 	end

end
