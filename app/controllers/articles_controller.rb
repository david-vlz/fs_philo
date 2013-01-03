class ArticlesController < ApplicationController

	def show
		@article = Article.find(params[:id])
	end

	def new
	end
	
	def update

	end
	
	def mercury_update
		@article = Article.find_by_id(params[:id])
		@article.title = params[:content][:article_title][:value]
		@article.body = params[:content][:article_body][:value]
		@article.save!
		render text: ''
	end
end
