
def sign_in(user)
	visit login_path
	fill_in "Email",    with: user.email
	fill_in "Passwort", with: user.password
	click_button "Login"
	# Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end

def sign_out
	click_link 'Logout'
end

def fill_in_article_form
	fill_in 'article_title', 						with: 'Test Heading'
	fill_in 'article_sections_attributes_0_title', 	with: 'Test Section Heading'
	fill_in 'article_sections_attributes_0_body', 	with: 'Lorem Ipsum dolor sit amet'
	fill_in 'article_sections_attributes_1_title', 	with: 'Test Section Heading'
	fill_in 'article_sections_attributes_1_body', 	with: 'Lorem Ipsum dolor sit amet'
end
