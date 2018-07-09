class BorrowsController < ApplicationController
  before_action :load_borrow, only: %i(edit update show)
  before_action :authenticate_user!, only: %i(index show create)

  def index
    @borrows = current_user.borrows.check_approve(true)
                           .order_by_time.page(params[:page])
                           .per Settings.borrow.per_page
  end

  def show
    @book_borrows = @borrow.book_borrows.includes(:book)
  end

  def new
    @borrow = Borrow.new
    @book_borrow = @borrow.book_borrows.build
    respond_to do |format|
      format.js
    end
  end

  def create
    if current_user.borrow_not_approve
      update_time_borrow
    else
      if current_user.can_borrow_book
        borrow = current_user.borrows.new nested_borrow_params
        if borrow.save
          flash[:notice] = t ".send_success"
        else
          show_flash_error borrow
        end
      else
        flash[:notice] = t ".not_return_old_book"
      end
    end
    redirect_to root_path
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @message = t ".update_success" if @borrow.update_attributes borrow_params
    respond_to do |format|
      format.js
    end
  end

  private
  def nested_borrow_params
    params.require(:borrow).permit :start_date, :end_date,
      book_borrows_attributes: [:book_id]
  end

  def borrow_params
    params.require(:borrow).permit :start_date, :end_date
  end

  def book_borrow_params
    nested_borrow_params[:book_borrows_attributes]["0"]
  end

  def create_book_borrow borrow
    book_borrow = borrow.book_borrows.new book_id: book_borrow_params[:book_id].to_i
    if book_borrow.save
      flash[:notice] = t ".send_success"
    else
      show_flash_error book_borrow
    end
  end

  def update_time_borrow
    borrow = current_user.borrows.check_approve(false).first
    if borrow.update_attributes borrow_params
      if borrow.book_borrows.find_book(book_borrow_params[:book_id].to_i).blank?
        create_book_borrow borrow
      else
        flash[:notice] = t ".update_time_success"
      end
    else
      show_flash_error borrow
    end
  end

  def load_borrow
    @borrow = Borrow.find_by id: params[:id] || not_found
  end
end
