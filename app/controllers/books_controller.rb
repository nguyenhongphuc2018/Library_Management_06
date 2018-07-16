class BooksController < ApplicationController
  before_action :load_book, only: %i(show)

  def index
    load_book_index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comments = @book.comments
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per Settings.page.comment
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def load_book
    @book = Book.find_by id: params[:id] || not_found
  end

  def load_book_index
    books = Book.searchs(params[:search])
                .ransack params[:q]
    books.sorts = "name asc" if books.sorts.empty?
    books = books.result(distinct: true)
    @num_result = books.count
    @filter_categories = Category.load_by_list_book(books.select(:id))
    @search_books = books.page(params[:page])
                         .per Settings.page.per
  end
end
