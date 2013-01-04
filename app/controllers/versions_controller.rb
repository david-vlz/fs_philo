class VersionsController < ApplicationController

	def show
		@version = Version.find_by_id(params[:id])
	end

	def list
		@versions = Article.find_by_id(params[:id]).versions
	end
	
	

end
