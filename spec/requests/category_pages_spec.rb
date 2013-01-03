# coding : utf-8

require 'spec_helper'

describe "Category pages" do
	
	subject { page }
	
	describe "presentation with multiple articles" do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		before do 
			3.times { |n| user.articles.create!(title: "title #{n}", body: "Lorem Ipsum #{n}", active: true, category_id: category.id) } 
			visit category_path(category)
		end
		let(:article) { category.articles.first }
		
		3.times do |n|
			it { should have_selector('h3', text: "title #{n}") }
			it { should have_selector('p.lead', text: "Lorem Ipsum #{n}") }
		end
		
		describe "for users not signed in" do
			it { should_not have_link('Artikel hinzufügen', href: new_article_path(category: category.id)) }
		end
		
		describe "for users signed in" do
			before do
			  sign_in user
			  visit category_path(category)
			end
			it { should have_link('Artikel hinzufügen', href: new_article_path(category: category.id)) }
		end
	end
	
end
