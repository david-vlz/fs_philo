class VersionsController < ApplicationController
	
	include VersionsHelper
	before_filter :signed_in_user
	
	def show
		@version = Version.find_by_id(params[:id])
		@article = @version.reify
		flash.now[:info] = "Das ist eine alte Version von \"#{@article.title}\"! \ 
			(Version Nr. #{@version.id} ge&auml;ndert durch \ 
			 \"#{whodunnit_string(@version)}\", am \
			 #{string_from_time(@version.created_at)})".html_safe
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
