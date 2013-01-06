class VersionsController < ApplicationController
	
	include VersionsHelper
	before_filter :signed_in_user
	
	def show
		@version = Version.find_by_id(params[:id])
		@article = @version.reify
	end

	def list
		@article = Article.find_by_id(params[:id])
		@versions = @article.versions.reverse
	end
	
	

end
