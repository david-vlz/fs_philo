FsPhilo::Application.routes.draw do
  
  get "articles/new"

  root to: 'static_pages#home'
  
  match 'contact', 			to: 'static_pages#contact'
  match 'veranstaltungen', 	to: 'static_pages#veranstaltungen'
  
  match 'cats', 			to: 'categories'

end
