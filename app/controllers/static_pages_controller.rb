class StaticPagesController < ApplicationController
	def home
		@categories = getCategories
	end
end
