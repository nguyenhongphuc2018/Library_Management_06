class BooksController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: %i(index show search_autocomplete)
  before_action :load_book, only: %i(show like follow)
  before_action :user_logged_in, only: %i(like follow)

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

  def search_autocomplete
    if params[:q].blank?
      render json: {}
    else
      load_search_autocomplete
      render json: {search: @search}
    end
  end

  def like
    @id = params[:id]
    if current_user.liked? @book
      @book.unliked_by current_user
    else
      @book.liked_by current_user
    end
    @total_like = @book.votes_for.size
    respond_to do |format|
      format.js
    end
  end

  def follow
    @id = params[:id]
    if current_user.following?(@book)
      current_user.stop_following(@book)
    else
      current_user.follow(@book)
    end
    @total_follow = @book.followers_count
    respond_to do |format|
      format.js
    end
  end

  private
  def load_book
    @book = Book.find_by(id: params[:id]) || not_found
  end

  def load_book_index
    books = Book.searchs(params[:search])
                .ransack params[:q]
    books.sorts = "name asc" if books.sorts.empty?
    books = books.result(distinct: true).includes(:authors)
    @num_result = books.count
    @filter_categories = Category.sort_category
                                 .select_category
    @search_books = books.page(params[:page])
                         .per Settings.page.per
  end

  def load_search_autocomplete
    book = Book.load_name_book params[:q]
    author = Author.load_name_author params[:q]
    @search = book + author
  end
end
