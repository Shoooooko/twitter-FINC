# frozen_string_literal: true

class FavPostsController < Users::BaseController
    before_action :set_post
    #before_action :favcount


  # def favcount
  #   favs = FavPost.where(post_id: @post.id)
  #   favcount = favs.count
  # end

  def create
    favs = FavPost.where(post_id: @post.id)
    favcount = favs.count
    if favs.where(user_id: @user.id).nil?
      @fav = FavPost.create(user_id: current_user.id,
                            post_id: params[:id])
      redirect_to posts_path,notice: 'いいねしました！'
    else
      flash[:notice] = 'すでにいいねしています'
      redirect_to posts_path
    end
  end

  def destroy
    favs = FavPost.where(post_id: @post.id)
    favcount = favs.count
    @fav = FavPost.find_by(post_id: @post.id, user_id: @user.id)
    if @fav == nil
      flash[:notice] = 'いいねしていません'
      redirect_to post_path(@post.id)
    elsif @fav.destroy
      flash[:notice] = '"いいね"が取り消されました。'
    redirect_to posts_path
    end
  end
  private
    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
