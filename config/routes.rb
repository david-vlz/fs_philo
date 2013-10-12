FsPhilo::Application.routes.draw do

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  mount Mercury::Engine => '/'

  resources :categories, :users, :events
  resources :sessions, only: [:new, :create, :destroy]
  resources :articles do
  	member { post :mercury_update }
  end

  root to: 'static_pages#home'
  
  match '/anmeldung', 	to: 'users#new'
  match '/impressum',   to: 'static_pages#impressum'
  match '/login', 		  to: 'sessions#new'
  match '/logout',      to: 'sessions#destroy', via: :delete
  
  match 'versions/revert/:id',		to: 'versions#revert', 	via: :post,	as: 'revert_version'
  match 'versions/articles/:id',	to: 'versions#list', 	via: :get, 	as: 'versions'
  match 'versions/:id', 			to: 'versions#show', 	via: :get, 	as: 'version'

end
