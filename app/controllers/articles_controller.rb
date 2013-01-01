class ArticlesController < ApplicationController

	def show
		@article = Article.find(params[:id])
	end
	
	def create
		@article = Article.new(params[:article])
		if @article && @article.save!
			flash[:success] = 'Artikel gespeichert!'
			redirect_to @article
		else
			flash[:error] = 'Etwas lief furchtbar schief. Bitte kontaktiere einen Administrator!'
		end
	end

	def new
		@article = Article.new(title: "Neuer Betirag")
		2.times { |n| @article.sections.build(title: "Abschnitt #{n+1}") }
	end
end
