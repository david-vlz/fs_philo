# coding : utf-8

class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Email und/oder Passwort sind ungültig'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end

end
