# frozen_string_literal: true

class HomesController < Users::BaseController
  # GET /posts
  # loginしなくてもアクセスできる
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :confirmation, only: :index
  skip_before_action :set_user, only: :index
  def index
    @posts = Post.where(trans: 1)
  end

  #mypage:loginしないとアクセスできない
  #@pageuserは、他人のmypage見るときのそのpageのowner

  def mypage
    @pageuser = @user
    binding.pry
    if getparams[:id]!=nil
      @pageuser = User.find_by(id: getparams[:id])
    end
    if @pageuser.id == @user.id
      @mypost = Post.where(user_id: current_user.id)
    #詳細見たいuserがloginuserをfollowしている、公開度：followers
    elsif current_user.followed?(@pageuser)
      @mypost = Post.where(user_id: @pageuser.id,trans: 3 )
    #詳細見たいuserがloginuserをfollowしていない、公開度：public
    else
      @mypost = Post.where(user_id: @pageuser.id,trans: 1 )
    end
  end
  private

  def getparams
    params.permit(:id)
  end
end
