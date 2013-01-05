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
			it_should_behave_like 'all article presentation pages'
			it_should_behave_like 'all article presentation pages for signed-out users'
		end
		
		describe 'for signed-in users' do
			before do
				sign_in user
				visit article_path(article)
			end
			
			it_should_behave_like 'all article presentation pages'
			it_should_behave_like 'all article presentation pages for signed-in users'
		end
		
	end	
end
