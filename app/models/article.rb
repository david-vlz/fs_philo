# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  category_id :integer
#  parent_id   :integer
#


#
# Each new article is a parent to his later editions (his children),
# who are represented as articles themselves
#
class Article < ActiveRecord::Base
	
	attr_accessible :active, :user_id, :category_id, :parent_id, :body, :title
  
	belongs_to :user
	belongs_to :category	
	
	has_paper_trail
	
	validates(:title, presence: true)
	validates(:body, presence: true)
	validates(:user_id, presence: true)
	validates(:category_id, presence: true)
	
end
