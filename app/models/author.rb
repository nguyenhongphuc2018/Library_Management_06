class Author < ApplicationRecord
  acts_as_followable

  has_many :author_books
  has_many :books, through: :author_books

  def load_image
    super
  end
end
