class User < ApplicationRecord

	attr_accessor :remember_token

	VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true ,length: {maximum: 50}
	validates :email, presence: true , length: {maximum: 255},
						format: {with: VALID_REGEX_EMAIL},
						uniqueness: {case_sensitive: false}
	validates :password, presence: true, length: {minimum: 6}
	has_secure_password

	def User.new_token
		return SecureRandom.urlsafe_base64
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string,cost: cost)
	end

	def remember
		self.remember_token=User.new_token
		update_attribute(:remember_digest , User.digest(remember_token))
	end

	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

end
