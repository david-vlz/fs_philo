# coding : utf-8

require 'spec_helper'

describe "Category pages" do
	
	subject { page }
	
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
