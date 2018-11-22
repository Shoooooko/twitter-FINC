# frozen_string_literal: true

class FavCommentsController < Users::BaseController
  before_action :set_comment
  before_action :favcount

  def favcount
    #favcount = 0
    favs = FavComment.where(comment_id: @comment.id)
    favcount = favs.count
  end

  def create
    @comments = Comment.where(id: @comment.id)
    if favcount == 0  || favs.where(user_id: @uesr.id != nil
      @fav = FavComment.create(user_id: current_user.id,
                                comment_id: @comment.id)
      redirect_to post_comments_path(@comment.post_id), notice: 'いいねしました！'
    else
      flash[:notice] = 'すでにいいねしています'
      redirect_to post_comments_path(id: @comment.id)
    end
  end

  def destroy
    @fav = FavComment.find_by(Comment_id: @comment.id, user_id: @user.id)
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
    def params_comment
      params.require(:comment).permit(:id, :body, :user_id, :Comment_id)
    end
end
