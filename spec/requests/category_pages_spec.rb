# coding : utf-8

require 'spec_helper'

describe "Category page" do
	
	subject { page }
	
	describe "with multiple articles" do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		let(:articles_amount) { 4 }
		let(:sections_amount) { 3 }
		before do
			sign_in user
			articles_amount.times do |n| 
				# TODO: Implement test for this that fails, user_id not to be changed that easily
				# category.articles.create!(title: "title #{n}", body: "Lorem Ipsum", active: true, user_id: user.id)
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
