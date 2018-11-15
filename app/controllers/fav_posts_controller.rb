# frozen_string_literal: true

class FavPostsController < Users::BaseController

  def create
    @favcount = 0
    #@favs = FavPost.where(post_id: params[:post])
    @favs = FavPost.where(post_id: params[:post])
    @favcount = @favs.count
    @post = Post.find_by(id: params[:post])
    if @favcount == 0
      @fav = FavPost.create(user_id: current_user.id,
                            post_id: params[:post])
      redirect_to posts_path,notice: 'いいねしました！'
    else
      flash[:notice] = 'すでにいいねしています'
      redirect_to post_path(params[:post], fav: @favcount)
    end
  end
end
