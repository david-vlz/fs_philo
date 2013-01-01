# coding : utf-8

require 'spec_helper'

describe 'Article Pages' do

	subject { page }
	
	describe 'creating an article' do
		
		before(:each) { visit new_article_path }
		
		describe 'the basic page layout' do
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
				fill_in 'article_title', 						with: 'Test Heading'
				fill_in 'article_sections_attributes_0_title', 	with: 'Test Section Heading'
				fill_in 'article_sections_attributes_0_body', 	with: 'Lorem Ipsum dolor sit amet'
				fill_in 'article_sections_attributes_1_title', 	with: 'Test Section Heading'
				fill_in 'article_sections_attributes_1_body', 	with: 'Lorem Ipsum dolor sit amet'
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
