# coding : utf-8

require 'spec_helper'

describe "Category pages" do
	
	subject { page }
	
	
	describe "adding a category" do
		let(:user) { FactoryGirl.create(:user) }
		before do 
			sign_in user
			visit new_category_path
		end
		
		describe "basic page layout" do
			it { should have_selector('title', text: 'Seite erstellen | ') }
			it { should have_selector('h3', text: 'Seite erstellen') }
		end
		
		describe "with valid input for a normal category" do
			before { fill_in 'Name', with: 'Test Kategorie' }
			
			it "should create a category" do
				expect { click_button 'Erstellen' }.to change(Category, :count).by(1)
			end
			
			describe "after saving the category" do
				let(:category) { Category.find_by_name('Test Kategorie') }
				before { click_button 'Erstellen' }
				
				it { should have_link(category.name, href: category_path(category.id) ) }
				it { should have_selector('title', text: "#{category.name} | ") }
				it { should have_selector('h3', text: category.name) }
				# it { should have_link('Beitrag hinzufügen', href: new_article_path ) } # TODO: fix
			end
		end
		
		describe "with invalid input" do
			before { fill_in 'Name', with: '' }
			
			it "should not create a category" do
				expect { click_button 'Erstellen' }.not_to change(Category, :count)
			end
		end
	end
	
	
	describe "presentation with multiple articles" do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		before do 
			3.times { |n| user.articles.create!(title: "title #{n}", body: "Lorem Ipsum #{n}", category_id: category.id) } 
			visit category_path(category)
		end
		let(:article) { category.articles.first }
		
		3.times do |n|
			it { should have_selector('h3', text: "title #{n}") }
			it { should have_selector('p.lead', text: "Lorem Ipsum #{n}") }
		end
		
		describe "for users not signed in" do
			it { should_not have_link('Beitrag hinzufügen', href: new_article_path(category: category.id)) }
		end
		
		describe "for users signed in" do
			before { sign_in user }
			before(:each) { visit category_path(category) }
			it { should have_link('Beitrag hinzufügen', href: new_article_path(category: category.id)) }
			
			describe "creating an article" do
				it "should create an article" do
					expect { click_link('Beitrag hinzufügen') }.to change(Article, :count).by(1)
				end
			end
		end
	end
	
end
