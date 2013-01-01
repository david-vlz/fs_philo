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
	
	describe "category articles overview" do
	
		describe "with multiple articles" do
			let(:category) { FactoryGirl.create(:category) }
			let(:user) { FactoryGirl.create(:user) }
			let(:articles_amount) { 4 }
			let(:sections_amount) { 3 }
			before do
				sign_in user
				articles_amount.times do |n| 
					article = user.articles.create!(title: "Article title #{n}", active: true, category_id: category.id)
					sections_amount.times do |m|
						article.sections.create!(title: "Section title #{m}", body: "Lorem Ipsum")
					end
				end
				visit category_path(category)
			end
		
			4.times do |n| 
				it { should have_selector('h3', text: "Article title #{n}") }
				it { should have_link("Article title #{n}") }
			end
			it { should have_selector('div#preview-section', text: "Lorem Ipsum..."), count: 4 }
			it { should have_link('Beitrag hinzufügen', href: new_article_path(category: category.id) ) }
		
		end
	end	
end
