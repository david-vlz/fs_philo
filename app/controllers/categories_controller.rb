class CategoriesController < ApplicationController

	def show
		@category = Category.find_by_id(params[:id])
		@articles = @category.articles
	end

	def new
	end

end
