Rails
  .application
  .routes
  .draw do
    get 'home/index'
    root 'home#index'
    resources :languages
    resources :tutorials

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    devise_for :users,
               controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
               }
  end
