class UsersController < ApplicationController
	def show
		@categories = getCategories
		@user = User.find_by_id(params[:id])
		@articles_by_user = @user.articles
	end

	def new
		@categories = Category.all
		@user = User.new
	end
	
	def index
		@categories = getCategories
		@users = User.all
	end
	
	def create
		@categories = getCategories
		@user = User.new(params[:user])
		if @user.save
			#TODO susccessfull save behandeln
		else
			render 'new'
		end
	end
	
end
