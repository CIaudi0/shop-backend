Rails.application.routes.draw do
  get '/auth/google_oauth2/callback', to: 'callbacks#google_oauth2'
  get "up" => "rails/health#show", as: :rails_health_check

  defaults format: :json do
    resources :products, only: [:index, :show]
    resources :orders, only: [:index, :show, :create]
    
    namespace :admin do
      resources :users, only: [:update, :destroy, :index]
      resources :products, only: [:update, :create, :destroy]
    end

    namespace :vendor do
      resources :products, only: [:update, :create, :destroy]
    end

    resource :cart, only: [:show] do
      post 'add/:product_id', to: 'carts#add_item'
      delete 'remove/:product_id', to: 'carts#remove_item'
      patch 'update/:product_id', to: 'carts#update_item'
    end
  end
end