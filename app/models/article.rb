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


#
# Each new article is a parent to his later editions (his children),
# who are represented as articles themselves
#
class Article < ActiveRecord::Base
	
	attr_accessible :active, :user_id, :category_id, :parent_id, :body, :title
  
	belongs_to :user
	belongs_to :category
	has_many :versions, :class_name => "Article", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Article"	
	
	def all_versions
		if (parent) then
			result = parent.versions
			result.push(parent)
		elsif
			result = versions
			result.push(self)
		end
		result
	end
	
	def other_versions
		all_versions - [self]
	end
	
	# this should only be one
	# TODO: test for multiples
	# TODO: raise exception if this is empty
	def active_versions
		all_versions.select { |version| version.active = true }
	end
	
	def set_others_inactive
		active_versions.each do |version|
			version.active = false
			version.save!
		end
	end
	
	def set_active
		falsify_different_versions()
		self.active = true
	end
	
	def save_edition
		set_active
		save!
	end
		
	
	validates(:title, presence: true)
	validates(:body, presence: true)
	validates(:user_id, presence: true)
	validates(:category_id, presence: true)

end
