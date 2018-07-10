class BooksController < ApplicationController
  before_action :load_book, only: :show

  def show; end

  private
  def load_book
    @book = Book.find_by id: params[:id] || not_found
  end
end
