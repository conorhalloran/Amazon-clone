Rails.application.routes.draw do

  
  # get 'reviews/new'

  # # CREATING NEW PRODUCT
  # get "products/new" => "products#new", as: :new_products 
  # post "products" => "products#create", as: :products 
  # #DESTROY IT!!!!!
  # delete "products/:id" => "products#destroy"
  # # INDEX PAGE:
  # get "products" => "products#index"

  # #SHOW PAGE:
  # get "products/:id" => "products#show", as: :product
  
  # # EDIT THE PRODUCT
  # get "products/:id/edit" => "products#edit", as: :edit_product
  # # PATCH IT TO MAKE EDIT WORK
  # patch "/products/:id" => "products#update"
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :categories, only: [:create]
  resources :tags, only: [:index, :show]
  resources :products do
    resources :favourites, shallow: true, only: [:create, :destroy]
    resources :reviews, shallow: true, only: [:create, :destroy] do
      resources :likes, shallow: true, only: [:create, :destroy]
    end
    
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end 

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/about" => "about#about", as: :about 
  get "/contact" => "contact#contact", as: :contact 
  post "/contact" => "contact#new"
  
  root "home#index"
end
