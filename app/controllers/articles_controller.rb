class ArticlesController < ApplicationController

	def show
		@categories = getCategories
		@article = Article.find(params[:id])
	end

	def new
	end
end
