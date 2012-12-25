FsPhilo::Application.routes.draw do

  resources :categories, :articles, :users

  root to: 'static_pages#home'
  
  match 'anmeldung', to: 'users#new'

end
