# coding : utf-8

require 'spec_helper'

describe 'Article Pages' do

	subject { page }
	
	describe 'creating an article' do
		
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user	
			visit new_article_path(category: category.id)
		end
		
		describe 'basic page layout' do
			it { should have_selector('title', text: 'Beitrag erstellen | ') }
			it { should have_selector('h3', text: 'Beitrag erstellen') }
#			it { should have_selector('div.info-box', text: 'Jeder Beitrag hat mehrere Abschnitte') }
#			it { should have_selector('i.icon-info-sign') }
			it { should have_selector('input[value="Neuer Betirag"]') }
			2.times { |n| it { should have_selector("input[value=\"Abschnitt #{n+1}\"]") } }
			2.times { |n| it { should have_selector("textarea[name=\"article[sections_attributes][#{n}][body]\"]") } }
#			it { should have_button('Neuer Abschnitt') }
			it { should have_button('Beitrag absenden') }
		end
		
		describe 'with valid input' do
			before(:each) do
				visit new_article_path(category: category.id)
				fill_in_article_form
			end
			
			it 'should create an article' do
				expect { click_button 'Beitrag absenden' }.to change(Article, :count).by(1)
			end
			it 'should create sections' do
				expect { click_button 'Beitrag absenden' }.to change(Section, :count).by(2)
			end
			
		end
		
	end
	
end
