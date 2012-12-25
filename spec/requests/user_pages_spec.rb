require 'spec_helper'

describe "User pages" do

	subject { page }
	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		
		it { should have_selector('h3', text: user.name) }
		it { should have_selector('p', text: user.email) }
		
		#TODO implement tests for users articles
		
	end


end
