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
	{ name: "red", email: "red@green.com", password: 'red1234', password_confirmation: 'red1234' }
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
	},
	{	
		user_id: User.find_by_name('Example User').id,
		category_id: Category.find_by_name('Bilder').id,
		title: 'Some long article',
		body: '<h2>by Josh Bloch</h2><p>This chapter describes the Java Collections Framework. Here you will learn what collections are and how they can make your job easier and programs better. You&#39;ll learn about the core elements &#151; interfaces, implementations, and algorithms &#151; that comprise the Java Collections Framework.</p><p><a href="intro/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Introduction</b></a> tells you what collections are, and how theyll make your job easierand your programs better.  Youll learn about the core elements thatcomprise the Collections Framework: <i>interfaces</i>, <i>implementations</i>and <i>algorithms</i>.</p><p><a href="interfaces/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Interfaces</b></a> describes the <i>core collection interfaces</i>, which are the heart and soulof the Java Collections Framework.  Youll learn general guidelines foreffective use of these interfaces, including when to use which interface.Youll also learn idioms for each interface that will help you get the mostout of the interfaces.</p><p><a href="implementations/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Implementations</b></a> describes the JDKs <i>general-purpose collection implementations</i>and tells you when to use which implementation.  Youll also learn aboutthe <i>wrapper implementations</i>, which add functionality to general-purposeimplementations.</p><p><a href="algorithms/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Algorithms</b></a> describes the <i>polymorphic algorithms</i> provided by the JDK to operateon collections.  With any luck youll never have to write your own sortroutine again!</p><p><a href="custom-implementations/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Custom Implementations</b></a> tells you why you might want to write your own collection implementation(instead of using one of the general-purpose implementations provided by theJDK), and how youd go about it.  Its easy with the JDKs <i>abstractcollection implementations</i>!</p><p><a href="interoperability/index.html"><img alt="trail icon" src="../images/coreIcon.gif" align="left" width="20" height="20" border="0" /><b>Interoperability</b></a>tells you how the Collections Framework interoperates with older APIs thatpredate the addition of Collections to Java.  Also, it tells you how to designnew APIs so that theyll interoperate seamlessly with other new APIs.</p>',
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
