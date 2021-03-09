class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: {minimum: 6}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email.downcase!
    email.strip!
    puts email, password
    user = User.find_by(email: email)&.authenticate(password)
    if !user
      user = nil
    end
    user
  end
end
