class ArticlesController < ApplicationController

	def show
		@article = Article.find_by_id(params[:id])
	end

	def new
		@user = current_user
		if @user
			@article = @user.articles.build(category_id: params[:category],
											title: "Beitrag #{Article.count+1}",
											body: "Hier einfach weiterschreiben :3")
			if @article && @article.save
				redirect_to @article
			else 
				flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator!'
			end
		else
			flash[:error] = 'Bitte logge dich ein, um diese Funktion zu nutzen.'
			redirect_to login_path
		end
	end
	
	def mercury_update
		@article = Article.find_by_id(params[:id])
		@article.title = params[:content][:article_title][:value]
		@article.body = params[:content][:article_body][:value]
		@article.save!
		render text: ''
	end
end
