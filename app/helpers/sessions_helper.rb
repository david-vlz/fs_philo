module SessionsHelper


	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end
	
	def signed_in?
		not current_user.nil?
	end
	
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end



	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		current_user == user
	end



	def store_location
		session[:return_to] = request.url
	end

	def redirect_back_or_to(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	# http://stackoverflow.com/questions/771656/
	def redirect_back_or_default(default = root_path, *options)
		tag_options = {}
		options.first.each { |k,v| tag_options[k] = v } unless options.empty?
		redirect_to (request.referer.present? ? :back : default), tag_options
	end

end
