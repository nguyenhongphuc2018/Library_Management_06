class Admin::BooksController < Admin::BaseController
  def index
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_url
    else
      render :new
    end
  end
  private
  def book_params
    params.require(:book).permit :name, :total_pages, :quantity, :description, :publisher_id, :image,
     :category_ids => [], :author_ids => []
  end
end
