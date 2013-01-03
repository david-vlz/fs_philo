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
	
	
	
	def store_save_url(url)
		session[:save_url] = url
	end
	
	def fetch_save_url
		session[:save_url]
	end

end
