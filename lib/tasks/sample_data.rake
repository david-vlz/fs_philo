namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		
		admin = User.create!(name: "red",
							 email: "red@green.com",
							 password: "red1234",
							 password_confirmation: "red1234")
		admin.toggle!(:admin)
		
		user_amount = 65
		
		user_amount.times do |n|
			name = Faker::Name.name
			email = Faker::Internet.email
			password = "secret-pwd"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end
		
		users = User.all
		
		categories = Category.create!([
			{ name: 'Veranstaltungen' },
			{ name: 'Bilder' },
			{ name: 'Kontakt', single_page: true}
		])
		
		categories.each do |category|
			if category.single_page?
				amount = 1
			else
				amount = rand(4..7)
			end
			amount.times do
				title = Faker::Lorem.words(rand(1..5)).join(' ')
				article = users[rand(0..user_amount)].articles.create!(title: title, category_id: category.id)
				rand(1..10).times do
					sec_title = Faker::Lorem.words(rand(1..10)).join(' ')
					sec_body = []
					rand(5..20).times { sec_body.push(Faker::Lorem.paragraph(rand(3..50))) }
					sec_body = '<p>' + sec_body.join('</p><p>') + '</p>'
					article.sections.create!(title: sec_title, body: sec_body)
				end
			end
		end
		
		
	end
end
