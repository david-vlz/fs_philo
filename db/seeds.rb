# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = Category.create([
	{ name: 'Veranstaltungen' },
	{ name: 'Bilder' },
	{ name: 'Kontakt', single_page: true}
])


users = User.create([
	{ name: 'david', email: 'dave@this.com', password: '345blauerFracK2/&%$', password_confirmation: '345blauerFracK2/&%$' },
	{ name: 'Example User', email: 'user@example.com', password: 'swordfish234!%&/', password_confirmation: 'swordfish234!%&/' },
	{ name: 'Jill', email: 'jill@stars.gov', password: 'haufenweise45&/(', password_confirmation: 'haufenweise45&/(' }
])


Article.create([
	{ 	
		user_id: User.find_by_name('Jill').id, 
		category_id: Category.find_by_name('Veranstaltungen').id,
		title: 'Erster Test Artikel', 
		body: '<p>some marked up text</p>', 
		active: true 
	},
	{
		user_id: User.find_by_name('Example User').id,
		category_id: Category.find_by_name('Kontakt').id,
		title: 'Kontakt',
		body: '<ul><li>Telefon: ######</li><li>Raumnr.: #######</li><li>mail: fs-philo@uni-koeln.de</li></ul>',
		active: true
	}
])

Article.create(
	{	
		user_id: User.find_by_name('Jill').id, 
		category_id: Category.find_by_name('Veranstaltungen').id, 
		title: 'Zweiter Test Artikel', 
		body: '<p>some marked up text</p>', 
		active: false
	}
)

Article.create([
	{	
		user_id: User.find_by_name('david').id, 
		category_id: Category.find_by_name('Veranstaltungen').id, 
		parent_id: Article.find_by_title('Erster Test Artikel').id,
		title: 'Erster Test Artikel-v2', 
		body: '<p>some changed text</p>', 
		active: false 
	},
	{	
		user_id: User.find_by_name('david').id, 
		category_id: Category.find_by_name('Veranstaltungen').id, 
		parent_id: Article.find_by_title('Erster Test Artikel').id,
		title: 'Erster Test Artikel-v3', 
		body: '<p>some text changed again</p>', 
		active: true 
	}
])
