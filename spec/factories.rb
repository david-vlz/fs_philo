FactoryGirl.define do
	factory :user do
		name		"Test User III."
		email		"schlimo.schlowi.deluxe@blubb.com"
		password	"wgah!nagl%fthagn"
		password_confirmation "wgah!nagl%fthagn"
	end
	
	factory :category do
		name	"Test Kategorie"
	end
end
