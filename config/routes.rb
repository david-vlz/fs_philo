FsPhilo::Application.routes.draw do
  
  root to: 'static_pages#home'
  
  match 'contact', 			to: 'static_pages#contact'
  match 'veranstaltungen', 	to: 'static_pages#veranstaltungen'

end
