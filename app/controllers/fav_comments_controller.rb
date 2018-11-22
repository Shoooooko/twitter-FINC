# frozen_string_literal: true

class FavCommentsController < Users::BaseController
  before_action :set_comment

  def create
    if @user.find_cfav?(@comment)
      redirect_to post_comments_path(@comment.post_id), notice:'すでにいいねしています'
    else
      @user.create_cfav(@comment)
      redirect_to post_comments_path(@comment.post_id), notice: 'いいねしました！'
    end
  end

  def destroy
    if @user.find_cfav?(@comment)
      @user.del_cfav(@comment)
      redirect_to post_comments_path(@comment.post_id), notice: 'いいねが取り消されました。'
    else
      redirect_to post_comments_path(@comment.post_id), notice: 'いいねしていません'
    end
  end

  private
    def set_comment
      @comment = Comment.find_by(id: params[:id])
      @comments = Comment.where(id: @comment.id)
    end
end
