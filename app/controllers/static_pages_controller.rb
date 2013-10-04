class StaticPagesController < ApplicationController
	def impressum
		@articles = Article.find(:all, order: 'updated_at DESC')
	end
end
