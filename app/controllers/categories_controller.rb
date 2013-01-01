class CategoriesController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]
	
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
			flash['success'] = 'Seite erstellt'
			redirect_to @category
		elsif
			render 'new'
		end
	end

end
