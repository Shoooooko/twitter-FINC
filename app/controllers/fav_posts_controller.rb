class FavPostsController < Users::BaseController
    before_action :set_post

  def create
    favs = @post.fav_posts
    favcount = favs.count
    if favcount == 0 || favs.find_by(user_id: @user.id) == nil
      binding.pry
      @fav = FavPost.create!(user_id: current_user.id,
                            post_id: params[:id])
      redirect_to posts_path,notice: 'いいねしました！'
    else
      redirect_to posts_path,notice:'すでにいいねしています'
    end
  end

  def destroy
    favs = @post.fav_posts
    favcount = favs.count
    @fav = favs.find_by(user_id: @user.id)
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
