class User < ApplicationRecord
	before_save :email_downcase
    has_secure_password# adds validations automatically. presence validation only checks for empty(nil) not blank(ex. '   ' is allowed), <=72, confirmation attribute
	validates :name, presence: true, length: {maximum: 15}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
    validates :password, presence:true, length: {minimum: 6 }, allow_nil: true#presence here ensures nonblank passwords
	def email_downcase
		self.email = email.downcase
	end
end
