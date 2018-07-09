class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :borrows
  has_many :comments
  has_many :comment_books, through: :comments, source: :book
  has_many :rates
  has_many :rate_books, through: :rates, source: :book

  enum role: {guest: 0, admin: 1, banned: 2}

  def load_avatar
    path = ActionController::Base.helpers
                                 .image_path(Settings.user.avatar_default)
    avatar.nil? ? path : avatar
  end

  def can_borrow_book
    if borrows.present? && borrows.check_approve(true)
                                  .present? && borrows.check_approve(true).last
                                  .book_borrows.unpaid.present?
      false
    else
      true
    end
  end

  def borrow_not_approve
    borrows.check_approve(false).present?
  end
end
