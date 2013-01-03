# coding : utf-8

require 'spec_helper'

describe "Category pages" do
	
	subject { page }
	
	describe "with multiple articles" do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		before do 
			3.times { |n| category.articles.create!(title: "title #{n}", body: "Lorem Ipsum #{n}", active: true, user_id: user.id) } 
			visit category_path(category)
		end
		let(:article) { category.articles.first }
		
		3.times do |n|
			it { should have_selector('h3', text: "title #{n}") }
			it { should have_selector('p.lead', text: "Lorem Ipsum #{n}") }
		end
		it { should have_link(article.title, href: article_path(article)) }
		it { should have_link('Artikel hinzufügen', href: new_article_path) }
	end
	
end
