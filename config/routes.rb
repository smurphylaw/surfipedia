Surfipedia::Application.routes.draw do


  devise_for :users, controllers: { registrations: 'users/registrations'}

  devise_scope :user do
    get 'register', to: 'devise/registrations#new'
  end
  
  resources :wikis
  resources :collaborations

  resources :users, only: [:index, :show]  

  get 'about' => 'welcome#about'

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end

  root to: 'welcome#index'

end
