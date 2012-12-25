FsPhilo::Application.routes.draw do

  get "users/show"

  get "users/new"

  resources :categories, :articles, :users

  root to: 'static_pages#home'
  
  match 'contact', 			to: 'static_pages#contact'
  match 'veranstaltungen', 	to: 'static_pages#veranstaltungen'

end
