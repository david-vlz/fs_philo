# coding: utf-8
# above: magic comment to handle umlaute in field names

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
	
	
	
	describe "signup" do
		
		before { visit anmeldung_path }
		
		let(:submit) { "Account erstellen" }
		
		describe "with invalid information" do
			it "should not create an account" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		
		describe "with valid information" do
			before do
				fill_in "Name",		with: "Schlimo Schlowi"
				fill_in "Email",	with: "ssd@example.com"
				fill_in "Passwort",	with: "blaBBBlubb2345//"
				fill_in "Passwort bestätigen", with: "blaBBBlubb2345//"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
		
	end


end
