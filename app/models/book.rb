class Book < ApplicationRecord
  acts_as_votable
  acts_as_followable

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
  validates :name, :total_pages, :quantity, :description, :publisher_id, :image,  presence: true
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :author_books
  accepts_nested_attributes_for :category_books

  scope :searchs, (lambda do |keyword|
    unless keyword.blank?
      ransack(
        publisher_name_cont: keyword,
        name_cont:  keyword,
        authors_name_cont: keyword,
        m: "or"
      ).result
    end
  end)

  scope :load_name_book, (lambda do |name|
    unless name.blank?
      select(:name)
      .ransack(name_cont: name)
      .result(distinct: true)
      .limit Settings.autocomplete.limit
    end
  end)

  def can_borrow?
    quantity > book_borrows.unpaid.count
  end

  def avg_rating
    rates.average(:point).to_f.round Settings.round
  end

  def load_image
    super
  end
end
