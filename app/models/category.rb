# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  single_page  :boolean
#  visible      :boolean          default(FALSE)
#  precursor_id :integer
#

class Category < ActiveRecord::Base
	
	attr_accessible :name, :single_page, :visible, :precursor_id 
	
	has_many :articles
	
	belongs_to :precursor, class_name: 'Category'

	validates(:name, presence: true)
	validates(:precursor_id, uniqueness: true)

	def insertion_attempt?(new_precursor_id)
		pre_id = precursor ? precursor.id : 0 	# zero because nil.to_i == 0, ''.to_i == 0
		pre_id != new_precursor_id.to_i
	end
	
	
	def successor
		Category.where(precursor_id: id).first
	end
	
	def successor=(category)
		category.precursor_id = id
	end

	# parameter can only be nil or an integer <= Category.count
	def move_after(new_precursor_id)
		categories = Category.all_in_succession
		categories.delete_if { |c| c.id == self.id }
		position = categories.index { |c| c.id == new_precursor_id }
		categories.insert( (position ? position+1 : 0) , self)
		Category.assign_new_succession(categories)
	end

	def self.all_in_succession
		all = []
		category = Category.where(precursor_id: nil).first
		(0...Category.count).each do
			all.push(category)
			category = category.successor
		end
		all
	end
	
	def self.assign_new_succession(categories)
		result = false
		if categories.count == Category.count
			transaction do
				(0...categories.count).each do |i|
					new_pre_id = (i == 0) ? nil : categories[i-1].id
					categories[i].update_attribute(:precursor_id, new_pre_id)
				end
				result = true
			end
		end
		result
	end

#	def extract_from_succession
#		self.successor.precursor = self.precursor
#	end

# Category.all_in_succession.each { |c| puts c.id.to_s + ' ' + c.precursor_id.to_s }

# Category.all.each { |c| c.precursor_id = c.id-1 } && Category.find(1).update_attribute(:precursor_id, nil)



	
end
