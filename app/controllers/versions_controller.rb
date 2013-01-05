class VersionsController < ApplicationController
	
	before_filter :signed_in_user
	
	def show
		@version = Version.find_by_id(params[:id])
	end

	def list
		@article = Article.find_by_id(params[:id])
		@versions = @article.versions.reverse
	end
	
	

end
