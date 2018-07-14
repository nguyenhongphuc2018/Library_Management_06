class RatesController < ApplicationController
  def create
    @book = Book.find_by(id: params[:rating][:book_id]) || not_found
    if current_user
      @rating = current_user.rates.build rating_parmas
      if @rating.save
        @book_id = params[:book_id]
      else
        @error = @rating.errors.full_messages.join("\n")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def rating_parmas
    params.require(:rating).permit(:point, :book_id)
  end
end
