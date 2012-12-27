# coding : utf-8

class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
		
		else
			flash.now[:error] = 'Email und/oder Passwort sind ungültig'
			render 'new'
		end
	end
	
	def destroy
	end

end
