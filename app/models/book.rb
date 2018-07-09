class Book < ApplicationRecord
  belongs_to :publisher
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :category_books
  has_many :categories, through: :category_books
  has_many :book_borrows
  has_many :borrows, through: :book_borrows
  has_many :comments
  has_many :comment_users, through: :comments, source: :user
  has_many :rates
  has_many :rate_users, through: :rates, source: :user
  accepts_nested_attributes_for :author_books
  accepts_nested_attributes_for :category_books
end
