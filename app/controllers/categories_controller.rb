class CategoriesController < ApplicationController

	def show
		@categories = getCategories
		@category = Category.find_by_id(params[:id])
		@articles = @category.articles
	end

	def new
	end

end
