require 'will_paginate/array'

class ArticlesController < ApplicationController
	
	before_filter :signed_in_user, except: [:show, :index]
	
	def show
		@article = Article.find_by_id(params[:id])
	end

	def index
		articles = Article.order('updated_at DESC')
		articles = articles.select { |a| a.visible? } unless signed_in?
		@articles = articles.paginate(page: params[:page], per_page: 8)
	end

	def new
		@user = current_user
		@article = @user.articles.build(category_id: params[:category],
										title: "Beitrag #{Article.count+1}",
										body: "Hier einfach weiterschreiben :3",
										precursor_id: Article.maximum('precursor_id')+1
										)
		if @article && @article.save && @article.move_bottom
			redirect_to @article
		else 
			flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator!'
		end
	end
	
	# handles only visibility and succession parameter changes.
	# Actual text/heading changed via Mercury editor
	def edit
		@article = Article.find(params[:id])
		if params[:visible]
			@article.update_attribute(:visible, (params[:visible]=='1') )
			if @article.category.single_page?
				@article.category.update_attribute(:visible, (params[:visible]=='1') )
			end
			flash[:success] = change_text
		elsif params[:move]
			if move_to_input_pos(@article, params[:move])
				flash[:success] = 'Beitrag verschoben!'
			end
		end
		redirect_back_or_default(@article)
	end
	
	def update
		@article = Article.find_by_id(params[:id])
		@article.title = params[:content][:article_title][:value]
		@article.body = params[:content][:article_body][:value]
		@article.save!
		render text: ''
	end

	def destroy
		@article = Article.find(params[:id])
		if @article && @article.destroy_from_succession
			flash[:success] = 'Der Beitrag wurde entfernt'
			redirect_to(@article.category)
		else
			flash[:error] = 'Irgendetwas ist schiefgelaufen. Bitte wende dich an den Systemadministrator'
			redirect_back_or_default(@article.category)
		end
	end

end
