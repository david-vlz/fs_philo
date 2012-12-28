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
		
		describe "basic page layout" do
			it { should have_selector('label[for="user_name"]', text: 'Name') }
			it { should have_selector('input[id="user_name"]') }
			it { should have_selector('label[for="user_email"]', text: 'Email') }
			it { should have_selector('input[id="user_email"]') }
			it { should have_selector('label[for="user_password"]', text: 'Passwort') }
			it { should have_selector('input[id="user_password"]') }
			it { should have_selector('label[for="user_password_confirmation"]', text: 'Passwort bestätigen') }
			it { should have_selector('input[id="user_password_confirmation"]') }
			it { should have_selector('input[class="btn btn-primary"][name="commit"][type="submit"][value="Account erstellen"]') }
		end
		
		let(:submit) { "Account erstellen" }
		
		describe "with invalid information" do
			
			it "should not create an account" do
				expect { click_button submit }.not_to change(User, :count)
			end
			
			describe "after submission" do 
				before { click_button submit }
				it { should have_selector('title', text: 'Anmelden') }
				it { should have_content('8 Fehler gefunden') }
				it { should have_selector('div[class="field_with_errors"]') }
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
			
			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by_email('ssd@example.com') }
				
				it { should have_selector('title', text: "User #{user.name} |") }
				it { should have_selector('div.alert.alert-success', text: 'Willkommen bei der Fachschaft!') }
				it { should have_selector('p', text: user.email) }
				it { should have_selector('i.icon-user') }
				it { should have_link('Logout', href: logout_path) }
			end
		end
		
	end
	
	
	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit edit_user_path(user) }
		
		describe "page" do
			it { should have_selector('h3', text: 'Profil bearbeiten') }
			it { should have_selector('title', text: 'Profil bearbeiten: ' + user.name + ' | ') }
		end
		
		describe "with invalid information" do
			before { click_button 'Ok' }
			it { should have_content('Fehler gefunden') }
		end
		
		describe "with invalid information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Name",					with: new_name
				fill_in "Email",				with: new_email
				fill_in "Passwort", 			with: user.password
				fill_in "Passwort bestätigen",	with: user.password
				click_button 'Ok'
			end
			
			it { should have_selector('title', text: "User #{new_name} | ") }
			it { should have_selector('div.alert.alert-success', text: 'Änderungen übernommen!') }
			it { should have_selector('p', text: new_email) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
			
		end
	end
	


end
