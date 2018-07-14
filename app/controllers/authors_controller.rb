class AuthorsController < ApplicationController
  authorize_resource
  skip_authorize_resource only: %i(show)
  before_action :load_author, only: %i(show follow)
  before_action :user_logged_in, only: :follow

  def show
    @books = @author.books.order(created_at: :asc)
                    .page(params[:page])
                    .per Settings.page.per
  end

  def follow
    @id = params[:id]
    if current_user.following?(@author)
      current_user.stop_following(@author)
    else
      current_user.follow(@author)
    end
    @total_follow = @author.followers_count
    respond_to do |format|
      format.js
    end
  end

  private
  def load_author
    @author = Author.find_by id: params[:id] || not_found
  end
end
