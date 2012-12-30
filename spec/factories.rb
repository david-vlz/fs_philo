FactoryGirl.define do
	factory :user do
		sequence(:name) 	{ |n| "Person #{n}" }
		sequence(:email) 	{ |n| "person_#{n}@example.com" }
		password	"wgah!nagl%fthagn"
		password_confirmation "wgah!nagl%fthagn"
	end
	
	factory :category do
		name	"Test Kategorie"
	end
end
