class BookBorrow < ApplicationRecord
  belongs_to :borrow
  belongs_to :book

  scope :unpaid, ->{where(return_date: nil)}
  scope :find_book, ->(book_id){where book_id: book_id}
end
