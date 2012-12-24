FsPhilo::Application.routes.draw do
  
#  get "categories/show"

#  get "categories/new"

#  get "articles/new"

  resources :categories

  root to: 'static_pages#home'
  
  match 'contact', 			to: 'static_pages#contact'
  match 'veranstaltungen', 	to: 'static_pages#veranstaltungen'
  
  match 'cats', 			to: 'categories'

end
