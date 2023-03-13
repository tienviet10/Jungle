class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: { minimum:3 }, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  

  def self.authenticate_with_credentials(email, password)
      clean_email = email.downcase.strip
      # user = User.find_by_email(clean_email)
      user = User.where('lower(email) = ?', clean_email).first
      
      if user && user.authenticate(password)
        user
      else
        nil
      end
  end
end
