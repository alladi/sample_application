class User < ActiveRecord::Base
	before_save { email.downcase! }   # similar to before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i   # ( Added more complex regex to reject email "foo@barr..com")
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX }, 
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }
end