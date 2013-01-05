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
		sequence(:id)		{ |n| }
		sequence(:title)	{ |n| "Title #{n}" }
		sequence(:body)		{ |n| "Body Text #{n}" }
	end
end
