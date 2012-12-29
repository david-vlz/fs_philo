class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
	
	
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
		if @user && @user.save
			sign_in @user
			flash[:success] = "Willkommen bei der Fachschaft!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	
	def edit
		@user = User.find_by_id(params[:id])
	end
	
	
	def update
		@user = User.find_by_id(params[:id])
		if @user && @user.update_attributes(params[:user])
			flash[:success] = "&Auml;nderungen &uuml;bernommen!".html_safe
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	
	
	private
		def signed_in_user
			if not signed_in?
				flash[:notice] = "Bitte loggen sie sich ein, um dieses Feature zu benutzen."
				redirect_to login_url
			end
		end
	
end
