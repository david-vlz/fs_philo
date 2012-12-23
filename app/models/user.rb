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
#

class User < ActiveRecord::Base
  
	attr_accessible(:email, :name, :password, :password_confirmation)
	
	has_many :articles
	has_secure_password    	
  
  	before_save { self.email.downcase! }
  
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:name, presence: true, 
					 length: { maximum: 50, minimum: 3 }
	)
	validates(:email, presence: true, 
					  format: VALID_EMAIL_REGEX,
					  uniqueness: { case_sensitive: false }
	)
	validates(:password, presence: true,
						 length: { minimum: 10 }
	)					 
	validates(:password_confirmation, presence: true)
end
