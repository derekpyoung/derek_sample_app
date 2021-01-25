class User < ApplicationRecord

  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format:{ with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  #return has digest of givin string

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::Min_Cost :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #returns random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

# remembers a user in the databse for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # forgets a users
  def forget
    update_attribute(:remember_digest, nil)
  end

  #returns true if given token matches digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  # Activates an account.
  def activate
  update_columns(activated: true)
  end

  private
  # converts email to downcase.
  def downcase_email
    self.email = email.downcase
  end



  # Sends activation email.



  #creates and assigns the activation token and password_digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
