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
	
	attr_accessible :active, :user_id, :category_id, :parent_id, :body, :title, :sections_attributes
  
	belongs_to :user
	belongs_to :category
	has_many :sections
	accepts_nested_attributes_for :sections
	has_many :versions, :class_name => "Article", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Article"	
	
	
	
	## FUNCTIONS FOR CREATING AND CHANGING THE ARTICLE BODY ##
	# stubs, TODO: add formats for article headings
#	def make_body_from_sections(sections = self.sections)
#		sections.each { |s| self.body += s.title + s.body } if sections.class == Array
#		sections.each { |s| self.body += s[:title] + s[:body] } if sections.class == Hash
#	end
	
	
	
	## FUNCTIONS FOR VERSIONING ##
	# use the "[].replace" to create a copy of versions
	# this protects the database from rails automagic, which will
	# create a parent_id for every element, that you push to self.versions
	def all_versions
		if (parent) then
			result = [].replace(parent.versions)
			result.push(parent)
		elsif
			result = [].replace(versions)
			result.push(self)
		end
		result
	end
	
	def other_versions
		all_versions - [self]
	end
	
	# this should only be one
	# TODO: test for multiples, raise exception
	# TODO: raise exception if this is empty
	def active_versions
		all_versions.select { |version| version.active == true }
	end
	
	def set_all_inactive
		active_versions.each do |version|
			version.active = false
			version.save!
		end
	end
	
	def set_active
		set_all_inactive
		self.active = true
	end
	
	def save_edition
		set_active
		save!
	end
	
	def check_acitivity_status
		if active_versions.length != 1
			errors.add(:active, "Exactly one active article should correspond to this one, there are #{active_versions.length}")
			return false
		end
		true
	end
		
	
	validates(:title, presence: true)
#	validates(:body, presence: true)
	validates(:user_id, presence: true)
	validates(:category_id, presence: true)
	validate :check_acitivity_status, on: :edit
	
end
