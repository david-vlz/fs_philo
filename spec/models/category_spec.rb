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

require 'spec_helper'

describe Category do
  
	before { @category = Category.new( name: 'Test Kategorie 123' ) }

	subject { @category }

	it { should be_valid }

	describe "when name is not present" do
		before { @category.name = " " }
		it { should_not be_valid }
	end
  
end
