class User < ApplicationRecord
  after_create :assign_default_role
  rolify

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :borrows
  has_many :comments
  has_many :comment_books, through: :comments, source: :book
  has_many :rates
  has_many :rate_books, through: :rates, source: :book
  has_many :users_roles
  has_many :roles, through: :users_roles

  acts_as_voter
  acts_as_follower

  def load_avatar
    path = ActionController::Base.helpers
                                 .image_path(Settings.user.avatar_default)
    avatar.nil? ? path : avatar
  end

  def can_borrow_book
    if borrows.present? && borrows.check_approve(true)
      .present? && borrows.check_approve(true)
      .last.book_borrows.unpaid.present?
      false
    else
      true
    end
  end

  def borrow_not_approve
    borrows.check_approve(false).present?
  end

  def check_rating book_id
    Rate.find_rating(id, book_id).any?
  end

  private
  def assign_default_role
    self.add_role(:guest) if self.roles.blank?
  end
end
