# coding : utf-8

require 'spec_helper'

describe 'Article Pages' do

	subject { page }
	
	let(:category) 	{ FactoryGirl.create(:category) }
	let(:user)		{ FactoryGirl.create(:user) }
	let(:article) 	{ FactoryGirl.create(:article, category_id: category.id, user_id: user.id) }

	describe 'presentation of basic page layout' do
		
		before { visit article_path(article.id) }
		
		describe 'for non-signed-in users' do
			it { should have_selector('title', text: article.title) }
			it { should have_selector('section', text: article.body) }
			it { should_not have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
			it { should_not have_link('Versionen anzeigen', href: versions_path(article.id)) }
		end
		
		describe 'for signed-in users' do
			before do
				sign_in user
				visit article_path(article)
			end
			
			it { should have_selector('title', text: article.title) }
			it { should have_selector('section', text: article.body) }
			it { should have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
			it { should_not have_link('Versionen anzeigen', href: versions_path(article.id)) }
			
			describe 'after an article has been updated' do
				before do 
					article.update_attributes(title: 'updated') 
					visit article_path(article)
				end
				it { should have_link('Versionen anzeigen', href: versions_path(article.id)) }
			end
		end
		
	end	
end
