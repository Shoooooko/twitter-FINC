# frozen_string_literal: true

class HomesController < Users::BaseController
  # GET /posts
  # loginしなくてもアクセスできる
  def index
    @posts = Post.where(trans: 1)
  end

  # mypageからtimeline
  # loginしないとアクセスできない
  #def show; end

  def mypage
    user = User.find_by(params[:id])
    if user.id == current_user.id
      @mypost = Post.where(user_id: current_user.id)
    #詳細見たいuserがloginuserをfollowしている、公開度：followers
    elsif current_user.followed(user)
      @mypost = Post.where(user_id: user.id,trans: 3 )
    #詳細見たいuserがloginuserをfollowしていない、公開度：public
    else
      @mypost = Post.where(user_id: user.id,trans: 1 )
    end
  end
end
