FsPhilo::Application.routes.draw do
  
  root to: 'static_pages#home'
  
  match 'contact', to: 'static_pages#contact'
  
  get "static_pages/home"

  get "static_pages/contact"

end
