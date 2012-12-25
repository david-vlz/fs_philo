class ApplicationController < ActionController::Base
	protect_from_forgery

	@categories = Category.all

	def getCategories
		Category.all
	end
end
