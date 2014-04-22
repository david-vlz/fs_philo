# coding : utf-8

class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by_email(params[:email_or_name])
		user ||= User.first(conditions: [ "lower(name) = ?", params[:email_or_name].downcase])
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_back_or_to user
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
