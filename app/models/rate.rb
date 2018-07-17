class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :find_rating, ->(id, book_id){where user_id: id, book_id: book_id}
end
