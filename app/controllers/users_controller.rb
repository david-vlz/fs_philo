class UsersController < ApplicationController
	def show
		@categories = getCategories
		@user = User.find_by_id(params[:id])
		@articles_by_user = @user.articles
	end

	def new
		@categories = Category.all
	end
	
	def index
		@categories = getCategories
		@users = User.all
	end
end
