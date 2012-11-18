# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  version    :integer
#  modifier   :string(255)
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fs_user_id :integer
#

require 'spec_helper'

describe Article do
	
	before { 
		@article = Article.new(
			fs_user_id: 3, 
			title: 'Erster Test Artikel', 
			body: '<p>some marked up text</p>', 
			version: 0,
			active: true
		)
	}
	
	subject { @article }

	it { should be_valid }

	it { should respond_to(:id) }
	it { should respond_to(:title) }
	it { should respond_to(:fs_user_id) }
	it { should respond_to(:body) }
	it { should respond_to(:version) }
	it { should respond_to(:modifier) }
	it { should respond_to(:active) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	

	describe "when title is not present" do
		before { @article.title = " " }
		it { should_not be_valid }
	end
	
	describe "when text is not present" do
		before { @article.body = " " }
		it { should_not be_valid }
	end
	
	describe "when version is not present" do
		before { @article.version = nil }
		it { should_not be_valid }
	end
	
	describe "when active is not set" do
		before { @article.active = nil }
		it { should_not be_valid }
	end
	
	describe "when no user is assigned to the article" do
		before { @article.fs_user_id = nil }
		it { should_not be_valid }
	end
	
	
	
	
end
