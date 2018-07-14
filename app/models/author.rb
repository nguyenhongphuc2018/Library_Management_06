class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books

  def load_image
    path = ActionController::Base.helpers
                                 .image_path(Settings.user.avatar_default)
    image.nil? ? path : image
  end
end
