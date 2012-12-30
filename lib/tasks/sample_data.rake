namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Example User",
					 email: "example-user@example.com",
					 password: "blue234",
					 password_confirmation: "blue234")
		99.times do |n|
			name = Faker::Name.name
			email = "example-user-#{n+1}@example.com"
			password = "secret-pwd"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end
	end
end
