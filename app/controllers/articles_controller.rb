class ArticlesController < ApplicationController

	def show
		@article = Article.find(params[:id])
	end
	
	def create
	
	end

	def new
		@article = Article.new(title: "Neuer Betirag")
		2.times { |n| @article.sections.build(title: "Abschnitt #{n+1}") }
	end
end
