FsPhilo::Application.routes.draw do

  mount Mercury::Engine => '/'

  resources :categories, :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :articles do
  	member { post :mercury_update }
  end

  root to: 'static_pages#home'
  
  match '/anmeldung', to: 'users#new'
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

end
