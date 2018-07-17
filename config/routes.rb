Rails.application.routes.draw do
  resources :books
  resources :borrows
  resources :book_borrows
  post "book/:id/like", to: "books#like", as: :like_book
  post "book/:id/follow", to: "books#follow", as: :follow_book
  post "author/:id/follow", to: "authors#follow", as: :follow_author
  get "book_borrows/:id/add_book_borrow", to: "book_borrows#add_book_borrow", as: :add_book_borrow
  root "static_pages#home"
  resources :books, only: %i(show index) do
    get "search-autocomplete", on: :collection
    resources :comments, only: %i(create destroy)
  end
  devise_for :users
  resources :users, only: :show
  resources :books
  resources :authors
end
