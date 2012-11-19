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
	{ name: 'Kontakt'}
])


users = User.create([
	{ name: 'david', email: 'dave@this.com', password: '345blauerFracK2/&%$', password_confirmation: '345blauerFracK2/&%$' },
	{ name: 'Example User', email: 'user@example.com', password: 'swordfish234!%&/', password_confirmation: 'swordfish234!%&/' },
	{ name: 'Jill', email: 'jill@stars.gov', password: 'haufenweise45&/(', password_confirmation: 'haufenweise45&/(' }
])


Article.create([
	{ fs_user_id: User.find_by_name('Jill').id, fs_category_id: Category.find_by_name('Kontakt').id, title: 'Erster Test Artikel', body: '<p>some marked up text</p>', version: 0, active: true },
	{ fs_user_id: User.find_by_name('Jill').id, fs_category_id: Category.find_by_name('Veranstaltungen').id, title: 'Zweiter Test Artikel', body: '<p>some marked up text</p>', version: 0, active: true },
])
