FsPhilo::Application.routes.draw do

  mount Mercury::Engine => '/'

  resources :categories, :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :articles do
  	member { post :mercury_update }
  end

  root to: 'articles#index'
  
  match '/anmeldung', 	to: 'users#new'
  match '/login', 		to: 'sessions#new'
  match '/logout', 		to: 'sessions#destroy', via: :delete
  
  match 'versions/revert/:id',		to: 'versions#revert', 	via: :post,	as: 'revert_version'
  match 'versions/articles/:id',	to: 'versions#list', 	via: :get, 	as: 'versions'
  match 'versions/:id', 			to: 'versions#show', 	via: :get, 	as: 'version'

end
