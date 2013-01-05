class ArticlesController < ApplicationController
	
	before_filter :signed_in_user, only:[:new, :mercury_update]
	
	def show
		@article = Article.find_by_id(params[:id])
	end

	def new
		@user = current_user
		@article = @user.articles.build(category_id: params[:category],
										title: "Beitrag #{Article.count+1}",
										body: "Hier einfach weiterschreiben :3")
		if @article && @article.save
			redirect_to @article
		else 
			flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator!'
		end
	end
	
	def update
		@article = Article.find_by_id(params[:id])
		@article.title = params[:content][:article_title][:value]
		@article.body = params[:content][:article_body][:value]
		@article.save!
		render text: ''
	end
end
