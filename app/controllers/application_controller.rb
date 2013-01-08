class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper
	include ApplicationHelper
	
	def show
		@categories = Cateogry.all
	end
	
	private
	
		def signed_in_user
			if not signed_in?
				store_location
				flash[:notice] = "Bitte logge dich ein, um diese Funktion nutzen zu k&ouml;nnen.".html_safe
				redirect_to login_url
			end
		end
		
		def correct_user
			@user = User.find_by_id(params[:id])
			redirect_to root_path unless current_user?(@user)
		end
		
		def admin_user
			redirect_to root_path unless current_user.admin?
		end
end
