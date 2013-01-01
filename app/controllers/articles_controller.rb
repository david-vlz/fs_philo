class ArticlesController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]

	def show
		@article = Article.find(params[:id])
	end
	
	def create
		@user = current_user
		if @user
			@article = @user.articles.build(params[:article])
			if @article && @article.save!
				flash[:success] = 'Artikel gespeichert!'
				redirect_to @article
			else
				flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator!'
			end
		else
			flash[:error] = 'Bitte logge dich ein, um diese Funktion zu nutzen.'
			redirect_to login_path
		end
	end

	def new
		@category_id = params[:category]
		@article = Article.new(title: "Neuer Betirag")
		2.times { |n| @article.sections.build(title: "Abschnitt #{n+1}") }
	end
end
