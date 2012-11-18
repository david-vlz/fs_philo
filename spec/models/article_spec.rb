# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  creator    :string(255)
#  html       :text
#  version    :integer
#  modifier   :string(255)
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Article do
	
	before { 
		@article = Article.new(
			creator: 'david', 
			title: 'Erster Test Artikel', 
			body: '<p>some marked up text</p>', 
			version: 0
		) 
	}
	
	subject { @article }
	
	it { should respond_to(:id) }
	it { should respond_to(:title) }
	it { should respond_to(:creator) }
	it { should respond_to(:body) }
	it { should respond_to(:version) }
	it { should respond_to(:modifier) }
	it { should respond_to(:active) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	
	
	
	
	
end
