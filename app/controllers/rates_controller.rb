class RatesController < ApplicationController
  before_action :user_logged_in, :load_book, only: :create
  def create
    @rating = current_user.rates.build rating_parmas
    if @rating.save
      save_avg_point
      @book_id = params[:book_id]
    else
      @error = @rating.errors.full_messages.join "\n"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def rating_parmas
    params.require(:rating).permit :point, :book_id
  end

  def load_book
    @book = Book.find_by(id: params[:rating][:book_id]) || not_found
  end

  def save_avg_point
    return if @book.update_attributes avg_rate: @book.avg_rating
    @error = t ".error"
  end
end
