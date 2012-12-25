class CategoriesController < ApplicationController

	def show
		@categories = getCategories
		@articles = Category.find_by_id(params[:id]).articles
	end

	def new
	end

end
