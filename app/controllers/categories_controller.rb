class CategoriesController < ApplicationController
  def show
  	@categories = getCategories
  	@articles = Category.find(params[:id]).articles
  end

  def new
  end
end
