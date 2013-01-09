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

require 'spec_helper'

describe Category do
  
	before { @category = Category.new( name: 'Test Kategorie 123' ) }

	subject { @category }
	
	it { should respond_to(:name) }
	it { should respond_to(:single_page) }
	it { should respond_to(:visible) }
	it { should respond_to(:articles) }
	
	it { should be_valid }

	describe "when name is not present" do
		before { @category.name = " " }
		it { should_not be_valid }
	end
  
end
