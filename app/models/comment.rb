class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true,
    length: {minimum: Settings.comment.content.minimum,
             maximum: Settings.comment.content.maximum}
  include ActionView::Helpers::DateHelper
  def show_time_create
    time_ago_in_words(created_at) unless created_at.blank?
  end
end
