class Admin::RequirementController < Admin::BaseController
  before_action :load_borrow, only: %i(show reject approve)
  def index
    load_borrows
  end

  def show
    @user = @borrow.user
    @book_borrows = @borrow.book_borrows
  end

  def reject
    if @borrow.update_attributes status: :reject
      if RequirementMailer.rejected(@borrow.user).deliver_later
        @borrow.update_attributes approve: true unless @borrow.approve
        @success = t ".success"
      else
        @error = t ".send_mail_error"
      end
    else
      @error = t ".update_error"
    end
    load_borrows
    respond_to :js
  end

  def approve
    if @borrow.update_attributes status: :approve
      if RequirementMailer.approved(@borrow.user).deliver_later
        @borrow.update_attributes approve: true unless @borrow.approve
        @success = t ".success"
      else
        @error = t ".send_mail_error"
      end
    else
      @error = t ".update_error"
    end 
    load_borrows
    respond_to :js
  end

  private
  def load_borrow
    @borrow = Borrow.find_by id: params[:id] || not_found
  end

  def load_borrows
    @q = Borrow.ransack(params[:q])

    @borrows = @q.result
                  .includes(:user)
                  .page(params[:page])
                  .per Settings.page.per
  end 
end
