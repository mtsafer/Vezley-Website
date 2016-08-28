class User < ApplicationRecord

	attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_update :allow_or_deny_custom_status
  validates :custom_status, length: { maximum: 15 }, uniqueness: { case_sensitive: false }, allow_nil: true
	#before_save { email.downcase! }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	#validates :name,  presence: true, length: {maximum: 50}
	#validates :email, presence: true, length: {maximum: 255},
	#										format: {with: VALID_EMAIL_REGEX},
	#								uniqueness: { case_sensitive: false }
	#validates :password, length: { minimum: 6 }, presence: true, allow_nil: true

	#has_secure_password

  has_many :posts
  has_many :comments
  has_many :contacts

	# Returns a digested hashing of the given string
	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Saves a remember_digest to the DB
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.logo = auth["info"]["image"]
    end
  end

  def update_pic(image)
    update_attribute(:logo, image)
  end

  def status
    if custom_status
      custom_status
    elsif owner == 1
      "Owner"
    elsif mod == 1
      "Moderator"
    else
      "viewer"
    end
  end

  def name_downcase
    name.downcase
  end

  def allow_or_deny_custom_status
    (posts.count + comments.count) >= 15 || owner == 1 || mod == 1 || name.downcase == "mountsafurious"
  end

  def icon
    if name.downcase == "mountsafurious"
      "http://pre12.deviantart.net/b248/th/pre/f/2013/247/e/3/dragon_icon_by_ferocefv-d6krb7y.png"
    elsif owner == 1
      "https://static2.fjcdn.com/comments/It+s+just+some+silly+gifs+no+it+s+a+symbol+of+_048c9c01797436dfc9e96b7e0e2ff793.png"
    elsif mod == 1
      "http://www.iconarchive.com/download/i91290/icons8/windows-8/Military-Sword.ico"
    else
      "http://www.clker.com/cliparts/s/I/Q/p/d/U/black-person-symbol-hi.png"
    end
  end

end
