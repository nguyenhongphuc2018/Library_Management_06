class CommentsController < ApplicationController
  before_action :user_logged_in, :load_book, only: %i(create destroy)
  def create
    if current_user
      @comment = build_comment
      @error = load_error_comment unless @comment.save
    else
      @error = t ".please_login"
    end
    load_comments
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if current_user.admin?
      @comment = Comment.find_by id: params[:id] || not_found
      @error = load_error_comment unless @comment.destroy
    else
      @error = t ".dont_permision"
    end
    load_comments
    respond_to do |format|
      format.js
    end
  end

  private
  def load_book
    @book = Book.find_by(id: params[:book_id]) || not_found
  end

  def load_comments
    @comments = @book.comments.order(created_at: :desc)
                     .page(params[:page])
                     .per Settings.page.comment
  end

  def comment_params
    params.require(:comment).permit(:content).merge book_id: params[:book_id]
  end

  def load_error_comment
    @comment.errors.full_messages.join("\n")
  end

  def build_comment
    current_user.comments.build comment_params
  end
end
