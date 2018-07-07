Rails.application.routes.draw do
  resources :books

  devise_for :users
  root "static_pages#home"
  resources :books
end
