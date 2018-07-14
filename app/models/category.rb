class Category < ApplicationRecord
  has_many :category_books
  has_many :books, through: :category_books
  scope :sort_category, ->{order name: :asc}
  scope :select_category, ->{select :id, :name}

  def self.load_by_list_book books
    return if books && !books.empty?
    joins(:category_books)
      .where("book_id IN (?)", books.select(:id))
      .group(:id, :name)
      .count(:book_id)
  end
end
