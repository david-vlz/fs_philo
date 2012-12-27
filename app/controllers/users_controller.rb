class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:id])
		@articles_by_user = @user.articles
	end

	def new
		@user = User.new
	end
	
	def index
		@users = User.all
	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Willkommen bei der Fachschaft!"
			sign_in @user
			redirect_to @user
		else
			render 'new'
		end
	end
	
end
