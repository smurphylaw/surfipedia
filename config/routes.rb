Surfipedia::Application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :wikis
  

  get 'about' => 'welcome#about'

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end

  root to: 'welcome#index'

end
