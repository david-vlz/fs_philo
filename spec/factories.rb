FactoryGirl.define do
	factory :user do
		sequence(:name) 	{ |n| "Person #{n}" }
		sequence(:email) 	{ |n| "person_#{n}@example.com" }
		password				"wgah!nagl%fthagn"
		password_confirmation 	"wgah!nagl%fthagn"
		
		factory :admin do
			admin true
		end
	end
	
	factory :category do
		name	"Test Kategorie"
	end
	
	factory :article do
		sequence(:title)	{ |n| "Section Title #{n}" }
		sequence(:body)		{ |n| "Section Text #{n}" }
		active 				true
	end
	
	factory :section do 
		sequence(:title)	{ |n| "Section Title #{n}" }
		sequence(:body)		{ |n| "Section Text #{n}" }
	end
end
