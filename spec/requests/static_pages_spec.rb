# coding : utf-8

require 'spec_helper'

describe "Static pages" do
  
	subject { page }
  
	shared_examples_for "all pages" do
		let(:category) 	{ FactoryGirl.create(:category) }
		let(:user)		{ FactoryGirl.create(:user) }
		
		describe "logged in" do
			before do
				sign_in user
				category.save
				visit current_path
			end	
		
			it { should have_selector('h1', text: 'Fachschaft Philosophie') }
			it { should have_link('Home', href: root_path) }
			it { should have_link(category.name, href: category_path(category)) }
			it { should have_link('Seite hinzufügen', href: new_category_path) }
			it { should have_link('Logout', href: logout_path) }
			it { should have_link('Profil', href: user_path(user)) }
			it { should have_link('Users', href: users_path) }
		end
		
		describe "not logged in" do
			it { should have_link('Login', href: login_path) }
			it { should_not have_link('Profil', href: user_path(user)) }
			it { should_not have_link('Users', href: users_path) }
		end
	end
	
	describe 'Home Page' do
		
		before { visit root_path }
		it_should_behave_like 'all pages'
	end
  
end
