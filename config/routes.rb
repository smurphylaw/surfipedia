Surfipedia::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations'}

  devise_scope :user do
    get 'register', to: 'devise/registrations#new'
  end

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end
  
  resources :wikis do
    member do
      get 'collaborators'
      put 'update_collaborators'
    end
  end

  

  get 'about' => 'welcome#about'

  

  root to: 'welcome#index'

end
