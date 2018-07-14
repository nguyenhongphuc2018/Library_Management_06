class AuthorsController < ApplicationController
  before_action :load_author, only: :show
  def show
    @books = @author.books.order(created_at: :asc)
                    .page(params[:page])
                    .per Settings.page.per
  end

  private
  def load_author
    @author = Author.find_by id: params[:id] || not_found
  end
end
