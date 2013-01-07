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
	
	def revert
		@version = Version.find(params[:id]).reify
		@article = Article.find(@version.id)
		@article = @version
		if @article.save
			flash[:success] = '&Auml;nderungen &uuml;bernommen!'.html_safe
			redirect_to @article
		else
			flash[:error] = 'Da ist was ziemlich schief gelaufen. Bitte kontaktiere einen Administrator'
			redirect_to root_path
		end
	end
	

end
