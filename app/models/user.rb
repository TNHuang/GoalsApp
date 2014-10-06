class User < ActiveRecord::Base
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end

  include BCrypt

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end


  def is_password?(password)
    Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.hex(16)
    self.save!
    self.session_token
  end


  def ensure_session_token
    self.session_token ||= SecureRandom.hex(16)
  end

end
