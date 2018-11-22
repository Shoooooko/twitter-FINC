# frozen_string_literal: true

class FavCommentsController < Users::BaseController
  before_action :set_comment

  def create
    favs = @comment.fav_comments
    favcount = favs.count
    @comments = Comment.where(id: @comment.id)
    if favcount == 0  ||favs.find_by(user_id: @user.id) == nil
      @fav = FavComment.create!(user_id: @user.id,
                                comment_id: @comment.id)
      redirect_to post_comments_path(@comment.post_id), notice: 'いいねしました！'
    else
      redirect_to post_comments_path(@comment.post_id), notice: 'すでにいいねしています'
    end
  end

  def destroy
    favs = @comment.fav_comments
    favcount = favs.count
    @fav = favs.find_by(user_id: @user.id)
    if @fav == nil
      redirect_to post_comments_path(@comment.post_id), notice:'いいねしていません'
    elsif @fav.destroy
      redirect_to post_comments_path(@comment.post_id), notice:'"いいね"が取りけされました.'
    end
  end

  private
    def set_comment
      @comment = Comment.find_by(id: params[:id])
    end
end
