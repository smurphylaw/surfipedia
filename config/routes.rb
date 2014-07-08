Surfipedia::Application.routes.draw do
  
  devise_for :users
  resources :wikis
  resources :subscriptions, only: [:new, :create]

  get 'about' => 'welcome#about'

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end

  root to: 'welcome#index'

end
