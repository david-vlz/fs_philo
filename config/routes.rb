FsPhilo::Application.routes.draw do

  resources :categories, :articles, :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'static_pages#home'
  
  match '/anmeldung', to: 'users#new'
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

end
