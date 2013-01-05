# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  single_page :boolean
#

class Category < ActiveRecord::Base
	
	attr_accessible :name, :single_page, :visible
	
	has_many :articles

	validates(:name, presence: true)
  
end
