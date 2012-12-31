# coding : utf-8

require 'spec_helper'

describe "Category pages" do
	
	subject { page }
	
	describe "with multiple articles" do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		let(:articles_amount) { 4 }
		before do 
			articles_amount.times { |n| category.articles.create!(title: "title #{n}", body: "Lorem Ipsum", active: true, user_id: user.id) } 
			visit category_path(category)
		end
		let(:article) { category.articles.first }

		it { should have_selector('h3', text: "title ", count: articles_amount) }
		it { should have_selector('p.lead', text: "Lorem Ipsum", count: articles_amount) }
		it { should have_selector('h3', text: article.title) }
		it { should have_link(article.title, href: article_path(article)) }
		it { should have_link('Artikel hinzufügen', href: new_article_path) }
	end 
	
end
