require 'spec_helper'

describe "Static pages" do
  
	subject { page }
  
	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: 'Fachschaft Philosophie') }
	end
	
	describe 'Home Page' do
		before { visit root_path }
		it_should_behave_like 'all static pages'
	end
  
end
