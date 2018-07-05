class Borrow < ApplicationRecord
  belongs_to :user
  has_many :book_borrows
  has_many :books, through: :book_borrows
end
