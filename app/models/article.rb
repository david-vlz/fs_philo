# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  version     :integer
#  modifier    :string(255)
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  category_id :integer
#

class Article < ActiveRecord::Base
	
	attr_accessible :active, :user_id, :category_id, :modifier, :body, :title, :version

	has_many :articles
  
	validates(:title, presence: true)
	validates(:body, presence: true)
	validates(:version, presence: true)
	validates(:active, presence: true)
	validates(:user_id, presence: true)
	validates(:category_id, presence: true)

end
