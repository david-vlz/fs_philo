class ApplicationController < ActionController::Base
	protect_from_forgery

	def getCategories
		Category.all
	end
end
