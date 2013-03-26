# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  category_id  :integer
#  visible      :boolean          default(FALSE)
#  precursor_id :integer
#  preview      :text
#

require 'spec_helper'

describe Article do
	
	before { 
		@article = Article.new(
			user_id: 3, 
			category_id: 4,
			title: 'Erster Test Artikel', 
			body: '<p>some marked up text</p>',
		)		
	}
	
	subject { @article }
	
	describe "when a new article is saved" do
		before { @article.save }
		it { should be_valid }
	end

	it { should respond_to(:id) }
	it { should respond_to(:title) }
	it { should respond_to(:user_id) }
	it { should respond_to(:category_id) }
	it { should respond_to(:user) }
	it { should respond_to(:category) }
	it { should respond_to(:body) }
	it { should respond_to(:versions) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	it { should respond_to(:visible) }
	

	describe "when title is not present" do
		before { @article.title = " " }
		it { should_not be_valid }
	end
	
	describe "when text is not present" do
		before { @article.body = " " }
		it { should_not be_valid }
	end
	
	describe "when no user is assigned" do
		before { @article.user_id = nil }
		it { should_not be_valid }
	end
	
	describe "when no category is assigned" do
		before { @article.category_id = nil }
		it { should_not be_valid }
	end
	
end
