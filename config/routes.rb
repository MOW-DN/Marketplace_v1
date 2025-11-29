Rails.application.routes.draw do
  resource :session
namespace :settings do
  resource :email, only: [ :show, :update ]
  resource :password, only: [ :show, :update ]
  resource :profile, only: [ :show, :update ]
  resource :user, only: [ :show, :destroy ]
  root to: redirect("/settings/profile")
end
namespace :email do
  resources :confirmations, param: :token, only: [ :show ]
end
    # Admins Only
  namespace :store do
    resources :products
    resources :users
    resources :wishlists
    resources :subscribers

    root to: redirect("/store/products")
  end
  resources :passwords, param: :token
  resource :sign_up
  resources :products do
    resource :wishlist, only: [ :create ], module: :products
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]
  resources :wishlists do
    resources :wishlist_products, only: [ :update, :destroy ], module: :wishlists
  end
  root "products#index"


  # get "/products", to: "products#index"
  # get "/products/new", to: "products#new"
  # post "/products", to: "products#create"
  # get "/products/:id", to: "products#show"
  # get "/products/:id/edit", to: "products#edit"
  # patch "/products/:id", to: "products#update"
  # put "/products/:id", to: "products#update"
  # delete "/products/:id", to: "products#destroy"
end
