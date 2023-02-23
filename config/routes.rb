Rails.application.routes.draw do
  root "sales#dashboard"
  resources :orders do
    collection do
      get '/:id/update_status/:status', to: "orders#update_status"
    end
  end
  devise_for :users
  resources :stores do
    collection do
      get "/:id/control", to: "stores#control"
      get "/:id/activate", to: "stores#activate"
      get "/:id/deactivate", to: "stores#deactivate"
      get '/:id/design', to: 'stores#design'
      patch '/:id/update_design', to: 'stores#update_design'
    end
  end
  resources :transactions
  resources :debts, only: [:index, :update, :edit, :destroy]
  resources :items
  resources :sales do
    collection do
      get :all
    end
  end
  resources :bills do
    collection do
      get :search
    end
  end
  resources :products
  resources :clients
  get '/category/:id', to: 'categories#show', constraints: { subdomain: 'app' }
  resources :categories

  get "/stores/:id/*path", to: "stores#show"
  get "/refresher", to: "stores#refresher"

  namespace :api do
    namespace :v1 do
      resources :stores, only: %i[show index]
      resources :clients, only: %i[show]
      resources :products, only: %i[index show create]
      resources :sessions, only: %i[create]
      resources :registrations, only: %i[create]
      resources :orders, only: %i[index create]
      resources :search, only: %i[index]
    end
  end
end
