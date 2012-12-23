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
	
	attr_accessible :active, :user_id, :category_id, :parent_id, :body, :title
  
	belongs_to :user
	belongs_to :category
	has_many :versions, :class_name => "Article", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Article"

	validates(:title, presence: true)
	validates(:body, presence: true)
	validates(:active, presence: true)
	validates(:user_id, presence: true)
	validates(:category_id, presence: true)

end
