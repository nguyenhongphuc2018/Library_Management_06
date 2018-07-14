Rails.application.routes.draw do
  root "static_pages#home"
  resources :books, only: %i(show index) do
    get "search-autocomplete", on: :collection
    resources :comments, only: %i(create destroy)
  end
  devise_for :users
  resources :users, only: :show
  resources :authors
  resources :rates
  namespace :admin do
    get "/", to: "dashbroads#index"
    resources :categories
  end
end
