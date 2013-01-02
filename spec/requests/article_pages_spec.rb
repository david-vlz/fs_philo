# coding : utf-8

require 'spec_helper'

describe 'Article Pages' do

	subject { page }
	
	let(:category) 	{ FactoryGirl.create(:category) }
	let(:user)		{ FactoryGirl.create(:user) }
	let(:article) 	{ FactoryGirl.create(:article, category_id: category.id, user_id: user.id) }

	describe 'presentation of basic page layout' do
		
		before { visit article_path(article.id) }
		
		shared_examples_for 'all article presentation pages' do
			it { should have_selector('title', text: article.title) }
			it { should have_selector('section', text: article.body) }
		end
		
		describe 'for non-signed-in users' do
			it_should_behave_like 'all article presentation pages'
			it { should_not have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
		end
		
		describe 'for signed-in users' do
			before do
				sign_in user
				visit article_path(article)
			end
			
			it_should_behave_like 'all article presentation pages'
			it { should have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
		end
		
	end	
end
