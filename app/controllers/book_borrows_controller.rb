class BookBorrowsController < ApplicationController
  before_action :load_book_borrow, only: %i(destroy create)

  def create
    borrow = current_user.borrows.check_approve(false).first
    if borrow.book_borrows.find_book(params[:id]).present?
      flash[:notice] = t ".sent_request"
    else
      create_book_borrow borrow
    end
    redirect_to root_path
  end

  def destroy
    @id = params[:id]
    borrow = @book_borrow.borrow
    @book_borrow.destroy
    borrow.destroy if borrow.book_borrows.any?
    respond_to do |format|
      format.js
    end
  end

  def add_book_borrow
    respond_to do |format|
      format.js
    end
  end

  private
  def load_book_borrow
    @book_borrow = BookBorrow.find_by id: params[:id] || not_found
  end

  def create_book_borrow borrow
    book_borrow = borrow.book_borrows.new book_id: params[:id]
    if book_borrow.save
      flash[:notice] = t ".send_success"
    else
      show_flash_error book_borrow
    end
  end
end
