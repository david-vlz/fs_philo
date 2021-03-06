# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base

  attr_accessible(:email, :name, :password, :password_confirmation)

  has_many :articles
  has_secure_password     

  before_save { self.email.downcase! }
  before_save :create_remember_token


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /^[a-zA-Z][a-zA-Z \-_]+$/

  validates(:name, 
    presence: true, 
    format: VALID_NAME_REGEX,
    length: { 
      maximum: 50, 
      minimum: 3 
    },
    uniqueness: {
      case_sensitive: false
    }
  )

  validates(:email, 
    presence: true, 
    format: VALID_EMAIL_REGEX,
    uniqueness: {
      case_sensitive: false
    }
  )

  validates(:password,
    presence: true,
    length: {
      minimum: 7
    }
  )

  validates(:password_confirmation, presence: true)


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
