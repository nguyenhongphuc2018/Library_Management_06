class Admin::RequirementController < Admin::BaseController
  def index
    @borrows = Borrow.page(params[:page])
                    .per Settings.page.per
  end

  def show
  end
end
