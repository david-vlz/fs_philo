class CategoriesController < ApplicationController

	def show
		@category = Category.find_by_id(params[:id])
		@articles = @category.articles
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category && @category.save
			flash[:success] = 'Seite erstellt!'
			redirect_to @category
		else
			flash[:error] = 'Da ist etwas furchtbar schiefgelaufen. Bitte kontaktiere einen Administrator'
			redirect_to root_path
		end
	end
end
