class Category < ApplicationRecord
  has_many :category_books
  has_many :books, through: :category_books

  scope :load_by_list_book, (lambda do |books|
    if books && !books.empty?
      joins(:category_books)
      .where("book_id IN (?)", books.select(:id))
      .group(:id, :name)
      .count(:book_id)
    end
  end)
end
