class User < ApplicationRecord
	attr_accessor :remember_token
	before_create :remember
	before_save :email_downcase

   has_secure_password# adds validations automatically. presence validation only checks for empty(nil) not blank(ex. '   ' is allowed), <=72, confirmation attribute
	validates :name, presence: true, length: {maximum: 35}#change from 15 to 35 for seeding to work
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
    validates :password, presence:true, length: {minimum: 6 }, allow_nil: true#presence here ensures nonblank passwords
	
  has_many :posts, dependent: :destroy
  
	#User prefix for clarity. This method is allowed to be used outside class
    def User.new_token
    	SecureRandom.urlsafe_base64
    end

    def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    #before_save
	def email_downcase
		self.email = email.downcase
	end
	#before_create

	#assigns encrypted random string to remember_digest
	def remember
        self.remember_token = User.new_token
        self.remember_digest = User.digest(remember_token)
	end

	#Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end 

  #forgets a user
  def forget
  	update_attribute(:remember_digest, nil)
  end

end
