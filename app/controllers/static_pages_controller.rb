class StaticPagesController < ApplicationController
	def home
		@articles = Article.find(:all, order: 'updated_at DESC')
	end
end
