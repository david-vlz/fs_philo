# coding: utf-8

require 'spec_helper'

describe "Authentication" do
	
	subject { page }
	
	describe "login page" do
		before { visit login_path }
		
		it { should have_selector('h3', text: 'Login') }
		it { should have_selector('title', text: 'Login | ') }
	end
	
	
	describe "login" do
		before { visit login_path }
		
		describe "with invalid information" do
			before { click_button 'Login' }
			let(:error_msg) { 'Email und/oder Passwort sind ungültig' }
			
			it { should have_selector('title', text: 'Login | ') }
			it { should have_selector('div.alert.alert-error', text: error_msg) }
			
			describe "after visiting another page" do
				before { click_link 'Home' }
				it { should_not have_content(error_msg) }
			end
		end
		
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				sign_in user
			end
			
			it { should have_selector('title', text: "User " + user.name + " | ") }
			it { should have_link('Profil', href: user_path(user)) }
			it { should have_link('Logout', href: logout_path) }
			it { should_not have_link('Login', href: login_path) }
			
			describe "followed by logout" do
				before { click_link('Logout') }
				it { should_not have_link('Logout') }
				it { should_not have_link('Profil') }
				it { should have_link('Login') }
			end
		end
	end
	
	
	describe "authorization" do
		
		describe "for non signed in users" do
			let(:user) { FactoryGirl.create(:user) }
			
			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user) # ungültiger Bearbeitungsversuch -> Weiterleitung zur Login-Seite
					fill_in "Email", with: user.email # Login nach Weiterleitung
					fill_in "Passwort", with: user.password
					click_button "Login"
				end
				
				describe "after signing in" do # weiterleitung zur Bearbeitunsseite
					it "should render the desired protected page" do
						page.should have_selector('title', text: "Profil bearbeiten: #{user.name} | ")
					end
					
					describe "and logging out and in again" do
						before do
							sign_out
							sign_in user
						end
						
						it "should not redirect to the protected page again" do
							page.should_not have_selector('title', text: 'Profil bearbeiten')
						end
					end
				end
			end
			
			describe "visiting the edit page" do
				before { visit edit_user_path(user) }
				it { should have_selector('title', text: "Login | ") }
			end
			
			describe "submitting to the update action" do
				before { put user_path(user) }
				specify { response.should redirect_to(login_path) }
			end
		end
		
		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, name: 'Wrong User', email: 'wrong@mail.com') }
			before { sign_in user }
			
			describe "visiting Users#edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_selector('title', text: 'Profil bearbeiten') }
			end
			
			describe "submitting a PUT request to the Users#update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end
		
	end
	
end
