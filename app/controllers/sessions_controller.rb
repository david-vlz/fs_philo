class SessionsController < ApplicationController

	def new
		@categories = Category.all
	end
	
	def create
	end
	
	def destroy
	end

end
