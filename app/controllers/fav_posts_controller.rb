# frozen_string_literal: true

class FavPostsController < Users::BaseController
  # before_action :exist_post, only: [:create]
  before_action :set_post, only: [:exist_post]
  # def exist_post
  #   @favcount = 0
  #   @favs = FavPost.where(post_id: params[:post])
  #   @favcount = @favs.count
  # end

  def create
    @favcount = 0
    @favs = FavPost.where(post_id: params[:post])
    @favcount = @favs.count
    @post = Post.find_by(id: params[:post])
    if @favcount == 0
      @fav = FavPost.create(user_id: current_user.id,
                            post_id: params[:post])
      redirect_to post_path(params[:post], fav: @favcount, notice: 'いいねしました！')
    else
      flash[:notice] = 'すでにいいねしています'
      redirect_to post_path(params[:post], fav: @favcount)
    end
  end

  private

  def set_post
    params.require(:post).permit(:id, :title, :body, :user_id)
  end
end
