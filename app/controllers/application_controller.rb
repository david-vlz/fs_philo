class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper
	
	
	private
		
		# before filters #
		
		def signed_in_user
			if not signed_in?
				store_location
				flash[:notice] = "Bitte loggen sie sich ein, um diese Funktion zu nutzen."
				redirect_to login_url
			end
		end
	
		def correct_user(user_id)
			@user = User.find_by_id(user_id)
			redirect_to root_path unless current_user?(@user)
		end
	
		def admin_user
			redirect_to root_path unless current_user.admin?
		end
end
