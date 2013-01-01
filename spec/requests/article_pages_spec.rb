# coding : utf-8

require 'spec_helper'

describe 'Article Pages' do

	subject { page }
	
	describe 'when creating an article' do
		
		before { visit new_article_path }
		
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
		
	end
	
end
