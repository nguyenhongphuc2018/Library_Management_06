class BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @search_books = Book.searchs(params[:search])
                        .page(params[:page])
                        .per Settings.page.per
  end

  def show; end

  private
  def load_book
    @book = Book.find_by id: params[:id] || not_found
  end
end
