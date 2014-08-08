Surfipedia::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    get 'register', to: 'devise/registrations#new'
  end

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end
  
  resources :wikis do
    resources :collaborators
  end

  resources :charges, only: [:new, :create]

  get '/wikis/public', to: 'wikis#public'
  root to: 'welcome#index'

end
