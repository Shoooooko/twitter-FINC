# frozen_string_literal: true

class FavCommentsController < Users::BaseController
  before_action :set_comment, only: [:exist_comment]
  def create
    @favcount = 0
    @favs = FavComment.where(comment_id: set_comment[:id])
    @favcount = @favs.count

    @post = Post.find_by(id: params[:post])
    @comments = Comment.where(post_id: params[:post])
    if @favcount == 0
      @fav = FavComment.create(user_id: current_user.id,
                               comment_id: set_comment[:id])
      if @fav.save
        redirect_to post_comments_path, notice: 'いいねしました！'
        #redirect_to post_comments_path(id: params[:comment], post_id: @post.id, fav: @favcount, notice: 'いいねしました！')
      else
        redirect_to post_comment_path(id: set_comment[:id], post_id: @post.id)
      end
    else
      # binding.pry
      flash[:notice] = 'すでにいいねしています'
      redirect_to post_comment_path(id: params[:comment], post_id: @post.id)
    end
  end

  private
  def set_comment
    params.require(:comment).permit(:id, :body, :user_id, :post_id)
  end
end
