# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
	has_secure_password
	
	before_save { self.email.downcase! }
	before_save :create_remember_token

	validates :password, length: { minimum: 8 }

	validates :password_confirmation, presence: true

	validates :name, presence: true, length: { maximum: 30 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	private 
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
