Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :products do
    resources :line_items, only: [ :new, :create]
    # collection do
    #   get :aretes
    #   get :anillos
    #   get :collares
    #   get :pulseras
    # end
  end
  resources :carts, only: [:show, :update, :create]
  resources :line_items, only: [ :update, :destroy]

  resources :products

  get "boughts", to: "products#bought", as: "boughts"

  get "sales", to: "products#sales", as: "sales"

  resources :cart, only: [:show]
  resources :line_items, only: [ :create, :update, :destroy]

  resources :carts do
    member do
      patch :close  # Ruta para cerrar el carrito
    end
  end
end
