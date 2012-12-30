class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	
	
	def show
		@user = User.find_by_id(params[:id])
		@articles_by_user = @user.articles
	end


	def new
		@user = User.new
	end
	
	
	def index
		@users = User.paginate(page: params[:page])
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
		#@user = User.find_by_id(params[:id]) # handled by before_filter
	end
	
	
	def update
		#@user = User.find_by_id(params[:id]) # handled by before_filter
		if @user && @user.update_attributes(params[:user])
			flash[:success] = "&Auml;nderungen &uuml;bernommen!".html_safe
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	
	def destroy
		@user = User.find_by_id(params[:id])
		if @user && @user.destroy
			flash[:success] = 'Der Benutzer wurde entfernt'
			redirect_to users_path
		else
			flash[:error] = 'Irgendetwas ist schiefgelaufen. Bitte wende dich an den Systemadministrator'
			redirect_to users_path
		end
	end
	
	
	
	private
	
		def signed_in_user
			if not signed_in?
				store_location
				flash[:notice] = "Bitte loggen sie sich ein, um diese Funktion zu nutzen."
				redirect_to login_url
			end
		end
		
		def correct_user
			@user = User.find_by_id(params[:id])
			redirect_to root_path unless current_user?(@user)
		end
	
end
