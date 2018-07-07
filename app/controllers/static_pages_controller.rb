class StaticPagesController < ApplicationController
  def home
    @new_books = Book.order(created_at: :asc).take Settings.new_books
  end
end
