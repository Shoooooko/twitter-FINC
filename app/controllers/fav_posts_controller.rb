# frozen_string_literal: true

class FavPostsController < Users::BaseController
    before_action :set_post
    before_action :favcount


  def favcount
    favcount = 0
    favs = FavPost.where(post_id: @post.id)
    favcount = favs.count
  end

  def create
    if favcount == 0 || favs.where(user_id: @user.id).count == 0
      @fav = FavPost.create(user_id: current_user.id,
                            post_id: params[:id])
      redirect_to posts_path,notice: 'いいねしました！'
    else
      flash[:notice] = 'すでにいいねしています'
      redirect_to posts_path
    end
  end

  def destroy
    @fav = FavPost.find_by(post_id: @post.id, user_id: @user.id)
    if @fav == nil
      flash[:notice] = 'いいねしていません'
      redirect_to post_path(@post.id)
    elsif @fav.destroy
      flash[:notice] = '"いいね" was successfully destroyed.'
    redirect_to posts_path
    end
  end
  private
    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
