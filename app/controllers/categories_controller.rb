class CategoriesController < ApplicationController

	before_filter :signed_in_user, except: [:show]

	def show
		@category = Category.find_by_id(params[:id])
		if @category && @category.single_page?
			redirect_to @category.articles.first
		else
			@articles = @category.articles
		end
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category && @category.save
			if @category.single_page?
				current_user.articles.create(title: @category.name, body: 'Hier einfach weiterschreiben ;)', category_id: @category.id)
			end
			flash[:success] = 'Seite erstellt!'
			redirect_to @category
		else
			flash[:error] = 'Da ist etwas ziemlich schiefgelaufen. Bitte kontaktiere einen Administrator'
			redirect_to root_path
		end
	end
end
