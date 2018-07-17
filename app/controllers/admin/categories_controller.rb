class Admin::CategoriesController < Admin::BaseController
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result
                  .page(params[:page])
                  .per Settings.admin.per
  end
end
