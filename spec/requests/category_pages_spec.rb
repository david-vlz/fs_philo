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
			before do 
				fill_in 'Name', with: 'Test Kategorie'
				choose 'blogartige Seite mit mehreren Beiträgen'
			end
			
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
		
		describe "with valid input for a single page category" do
			before do
				fill_in 'Name', with: 'Test mit einem Beitrag'
				choose 	'Seite mit einem Beitrag'
			end
			
			it "should create the category" do
				expect { click_button 'Erstellen' }.to change(Article, :count).by(1)
			end
			
			it "should create an article corresponding to the category" do
				expect { click_button 'Erstellen' }.to change(Article, :count).by(1)
			end
			
			describe "after saving the category the article should be displayed" do
				before { click_button 'Erstellen' }
				let(:category) { Category.find_by_name('Test mit einem Beitrag') }
				
				it { should have_selector('title', text: "#{category.articles.first.title} | ") }
				it { should have_selector('h3', text: category.articles.first.title) }
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
		let(:visible_article) { FactoryGirl.create(:article, user_id: user.id, category_id: category.id, visible: true) }
		let(:invisible_article) { FactoryGirl.create(:article, user_id: user.id, category_id: category.id, visible: false) }
		before do
			invisible_article.save
			visible_article.save
			visit category_path(category)
		end
		
		describe "for users not signed in" do
			it { should have_selector('h3', text: visible_article.title) }
			it { should_not have_selector('h3', text: invisible_article.title) }
			it { should_not have_link('Beitrag hinzufügen', href: new_article_path(category: category.id)) }
		end
		
		describe "for users signed in" do
			before { sign_in user }
			before(:each) { visit category_path(category) }

			it { should have_selector('h3', text: visible_article.title) }
			it { should have_selector('h3', text: invisible_article.title) }
			it { should have_link('Beitrag sichtbar machen') }
			it { should have_link('Beitrag verbergen') }			
			it { should have_link('Beitrag hinzufügen', href: new_article_path(category: category.id)) }
			
			describe "creating an article" do
				it "should create an article" do
					expect { click_link('Beitrag hinzufügen') }.to change(Article, :count).by(1)
				end
			end
		end
	end
	
	describe "presentation with a single article" do
		let(:category) { FactoryGirl.create(:category, single_page: true) }
		let(:user) { FactoryGirl.create(:user) }
		let(:single_article) { FactoryGirl.create(:article, user_id: user.id, category_id: category.id, visible: true) }
		
		describe "should redirect to that article" do
			before { visit category_path(category) }
			specify { response.should redirect_to article_path(single_article) }
		end
	end
	
end
