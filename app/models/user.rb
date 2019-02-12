class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
	validates :name, presence: true, length: { maximum: 40 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum:6 }

	has_many :sent_friend_requests, :foreign_key => "sender_id", :class_name => "FriendRequest" , dependent: :destroy
	has_many :received_friend_requests, :foreign_key => "receiver_id", :class_name => "FriendRequest", dependent: :destroy

	has_many :friendships , dependent: :destroy
	has_many :friends, :through => :friendships

	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => :friend_id
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	has_many :posts, foreign_key: :author_id, dependent: :destroy
	has_many :likes, foreign_key: :user_id, dependent: :destroy
	has_many :comments, foreign_key: :user_id, dependent: :destroy

 # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Activates an account
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	# Sends activation email
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end



	private

		#lower case email
		def downcase_email
			self.email = email.downcase 
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
