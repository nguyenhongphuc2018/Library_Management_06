Rails.application.routes.draw do
  root "static_pages#home"
  resources :books, only: %i(show index) do
    resources :comments, only: %i(create destroy)
  end
  devise_for :users
  resources :users, only: :show
  resources :books
end
