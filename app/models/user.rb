class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :borrows
  has_many :comments, dependent: :destroy
  has_many :comment_books, through: :comments, source: :book
  has_many :rates
  has_many :rate_books, through: :rates, source: :book

  enum role: {guest: 0, admin: 1, banned: 2}

  def load_avatar
    path = ActionController::Base.helpers
                                 .image_path(Settings.user.avatar_default)
    avatar.nil? ? path : avatar
  end

  def check_rating book_id
    Rate.where(user_id: id, book_id: book_id).any?
  end
end
